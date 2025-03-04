/datum/game_mode
	var/list/datum/mind/wizards = list()
	var/list/datum/mind/apprentices = list()

/datum/game_mode/wizard
	name = "wizard"
	config_tag = "wizard"
	tdm_gamemode = TRUE
	required_players = 20
	required_enemies = 1
	recommended_enemies = 1
	single_antag_positions = list()
	var/use_huds = TRUE

	var/finished = FALSE
	var/but_wait_theres_more = FALSE

/datum/game_mode/wizard/announce()
	to_chat(world, "<B>The current game mode is - Wizard!</B>")
	to_chat(world, "<B>There is a <font color='red'>SPACE WIZARD</font> on the station. You can't let him achieve his objective!</B>")

/datum/game_mode/wizard/can_start()//This could be better, will likely have to recode it later
	if(!..())
		return 0
	var/list/datum/mind/possible_wizards = get_players_for_role(ROLE_WIZARD)
	if(possible_wizards.len==0)
		return 0
	var/datum/mind/wizard = pick(possible_wizards)

	wizards += wizard
	modePlayer += wizard
	wizard.assigned_role = SPECIAL_ROLE_WIZARD //So they aren't chosen for other jobs.
	wizard.special_role = SPECIAL_ROLE_WIZARD
	wizard.set_original_mob(wizard.current)
	if(GLOB.wizardstart.len == 0)
		to_chat(wizard.current, "<span class='danger'>A starting location for you could not be found, please report this bug!</span>")
		return 0
	return 1

/datum/game_mode/wizard/pre_setup()
	for(var/datum/mind/wiz in wizards)
		wiz.current.loc = pick(GLOB.wizardstart)
	..()
	return 1

/datum/game_mode/wizard/post_setup()
	for(var/datum/mind/wizard in wizards)
		log_game("[key_name(wizard)] has been selected as a Wizard")
		forge_wizard_objectives(wizard)
		equip_wizard(wizard.current)
		INVOKE_ASYNC(src, PROC_REF(name_wizard), wizard.current)
		greet_wizard(wizard)
		if(use_huds)
			update_wiz_icons_added(wizard)

	..()

/datum/game_mode/proc/remove_wizard(datum/mind/wizard_mind)
	if(wizard_mind in wizards)
		SSticker.mode.wizards -= wizard_mind
		wizard_mind.special_role = null
		wizard_mind.current.create_attack_log("<span class='danger'>De-wizarded</span>")
		wizard_mind.current.create_log(CONVERSION_LOG, "De-wizarded")
		wizard_mind.current.spellremove(wizard_mind.current)
		wizard_mind.current.faction = list("Station")
		if(issilicon(wizard_mind.current))
			to_chat(wizard_mind.current, "<span class='userdanger'>You have been turned into a robot! You can feel your magical powers fading away...</span>")
		else
			to_chat(wizard_mind.current, "<span class='userdanger'>You have been brainwashed! You are no longer a wizard.</span>")
		SSticker.mode.update_wiz_icons_removed(wizard_mind)

/datum/game_mode/proc/update_wiz_icons_added(datum/mind/wiz_mind)
	var/datum/atom_hud/antag/wizhud = GLOB.huds[ANTAG_HUD_WIZ]
	wizhud.join_hud(wiz_mind.current)
	set_antag_hud(wiz_mind.current, ((wiz_mind in wizards) ? "hudwizard" : "apprentice"))

/datum/game_mode/proc/update_wiz_icons_removed(datum/mind/wiz_mind)
	var/datum/atom_hud/antag/wizhud = GLOB.huds[ANTAG_HUD_WIZ]
	wizhud.leave_hud(wiz_mind.current)
	set_antag_hud(wiz_mind.current, null)

/datum/game_mode/proc/forge_wizard_objectives(datum/mind/wizard)
	wizard.add_mind_objective(/datum/objective/wizchaos)

/datum/game_mode/proc/name_wizard(mob/living/carbon/human/wizard_mob)
	//Allows the wizard to choose a custom name or go with a random one. Spawn 0 so it does not lag the round starting.
	var/wizard_name_first = pick(GLOB.wizard_first)
	var/wizard_name_second = pick(GLOB.wizard_second)
	var/randomname = "[wizard_name_first] [wizard_name_second]"
	var/newname = sanitize(copytext(input(wizard_mob, "You are the Space Wizard. Would you like to change your name to something else?", "Name change", randomname) as null|text,1,MAX_NAME_LEN))

	if(!newname)
		newname = randomname

	wizard_mob.real_name = newname
	wizard_mob.name = newname
	if(wizard_mob.mind)
		wizard_mob.mind.name = newname

/datum/game_mode/proc/greet_wizard(datum/mind/wizard, you_are=1)
	addtimer(CALLBACK(wizard.current, TYPE_PROC_REF(/mob, playsound_local), null, 'sound/ambience/antag/ragesmages.ogg', 100, 0), 30)
	var/list/messages = list()
	if(you_are)
		messages.Add("<span class='danger'>You are the Space Wizard!</span>")
	messages.Add("<b>The Space Wizards Federation has given you the following tasks:</b>")

	messages.Add(wizard.prepare_announce_objectives(title = FALSE))
	messages.Add("<span class='motd'>For more information, check the wiki page: ([GLOB.configuration.url.wiki_url]/index.php/Wizard)</span>")
	to_chat(wizard.current, chat_box_red(messages.Join("<br>")))
	wizard.current.create_log(MISC_LOG, "[wizard.current] was made into a wizard")

/datum/game_mode/proc/equip_wizard(mob/living/carbon/human/wizard_mob)
	if(!istype(wizard_mob))
		return

	//So zards properly get their items when they are admin-made.
	qdel(wizard_mob.wear_suit)
	qdel(wizard_mob.head)
	qdel(wizard_mob.shoes)
	qdel(wizard_mob.r_hand)
	qdel(wizard_mob.r_store)
	qdel(wizard_mob.l_store)

	if(isplasmaman(wizard_mob))
		wizard_mob.equipOutfit(new /datum/outfit/plasmaman/wizard)
		wizard_mob.internal = wizard_mob.r_hand
		wizard_mob.update_action_buttons_icon()
	else
		wizard_mob.equip_to_slot_or_del(new /obj/item/clothing/under/color/lightpurple(wizard_mob), SLOT_HUD_JUMPSUIT)
		wizard_mob.equip_to_slot_or_del(new /obj/item/clothing/head/wizard(wizard_mob), SLOT_HUD_HEAD)
		wizard_mob.dna.species.after_equip_job(null, wizard_mob)
	wizard_mob.rejuvenate() //fix any damage taken by naked vox/plasmamen/etc while round setups
	wizard_mob.equip_to_slot_or_del(new /obj/item/radio/headset(wizard_mob), SLOT_HUD_LEFT_EAR)
	wizard_mob.equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal(wizard_mob), SLOT_HUD_SHOES)
	wizard_mob.equip_to_slot_or_del(new /obj/item/clothing/suit/wizrobe(wizard_mob), SLOT_HUD_OUTER_SUIT)
	wizard_mob.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(wizard_mob), SLOT_HUD_BACK)
	if(wizard_mob.dna.species.speciesbox)
		wizard_mob.equip_to_slot_or_del(new wizard_mob.dna.species.speciesbox(wizard_mob), SLOT_HUD_IN_BACKPACK)
	else
		wizard_mob.equip_to_slot_or_del(new /obj/item/storage/box/survival(wizard_mob), SLOT_HUD_IN_BACKPACK)
	wizard_mob.equip_to_slot_or_del(new /obj/item/teleportation_scroll(wizard_mob), SLOT_HUD_RIGHT_STORE)
	var/obj/item/spellbook/spellbook = new /obj/item/spellbook(wizard_mob)
	spellbook.owner = wizard_mob
	wizard_mob.equip_to_slot_or_del(spellbook, SLOT_HUD_LEFT_HAND)

	wizard_mob.faction = list("wizard")
	wizard_mob.mind.offstation_role = TRUE



	to_chat(wizard_mob, "You will find a list of available spells in your spell book. Choose your magic arsenal carefully.")
	to_chat(wizard_mob, "The spellbook is bound to you, and others cannot use it.")
	to_chat(wizard_mob, "In your pockets you will find a teleport scroll. Use it as needed.")
	wizard_mob.mind.store_memory("<B>Remember:</B> do not forget to prepare your spells.")
	wizard_mob.update_icons()
	wizard_mob.gene_stability += DEFAULT_GENE_STABILITY //magic
	return TRUE

// Checks if the game should end due to all wizards and apprentices being dead, or MMI'd/Borged
/datum/game_mode/wizard/check_finished()
	var/wizards_alive = 0
	var/apprentices_alive = 0

	// Wizards
	for(var/datum/mind/wizard in wizards)
		if(!iscarbon(wizard.current) || wizard.current.stat == DEAD) // wizard is in an MMI, don't count them as alive
			continue
		wizards_alive++

	// Apprentices
	if(!wizards_alive)
		for(var/datum/mind/apprentice in apprentices)
			if(!iscarbon(apprentice.current))
				continue
			if(apprentice.current.stat==DEAD)
				continue
			if(istype(apprentice.current, /obj/item/mmi)) // apprentice is in an MMI, don't count them as alive
				continue
			apprentices_alive++

	if(wizards_alive || apprentices_alive || but_wait_theres_more)
		return ..()
	else
		finished = TRUE
		return 1

/datum/game_mode/wizard/declare_completion(ragin = 0)
	if(finished && !ragin)
		SSticker.mode_result = "wizard loss - wizard killed"
		to_chat(world, "<span class='warning'><FONT size = 3><B> The wizard[(wizards.len>1)?"s":""] has been killed by the crew! The Space Wizards Federation has been taught a lesson they will not soon forget!</B></FONT></span>")
	..()
	return 1

/datum/game_mode/proc/auto_declare_completion_wizard()
	if(length(wizards))
		var/list/text = list("<br><font size=3><b>the wizards/witches were:</b></font>")

		for(var/datum/mind/wizard in wizards)

			text += "<br><b>[wizard.get_display_key()]</b> was <b>[wizard.name]</b> ("
			if(wizard.current)
				if(wizard.current.stat == DEAD)
					text += "died"
				else
					text += "survived"
				if(wizard.current.real_name != wizard.name)
					text += " as <b>[wizard.current.real_name]</b>"
			else
				text += "body destroyed"
			text += ")"

			var/count = 1
			var/wizardwin = 1
			for(var/datum/objective/objective in wizard.get_all_objectives(include_team = FALSE))
				if(objective.check_completion())
					text += "<br><B>Objective #[count]</B>: [objective.explanation_text] <font color='green'><B>Success!</B></font>"
					SSblackbox.record_feedback("nested tally", "wizard_objective", 1, list("[objective.type]", "SUCCESS"))
				else
					text += "<br><B>Objective #[count]</B>: [objective.explanation_text] <font color='red'>Fail.</font>"
					SSblackbox.record_feedback("nested tally", "wizard_objective", 1, list("[objective.type]", "FAIL"))
					wizardwin = 0
				count++

			if(wizard.current && wizard.current.stat!=DEAD && wizardwin)
				text += "<br><font color='green'><B>The wizard was successful!</B></font>"
				SSblackbox.record_feedback("tally", "wizard_success", 1, "SUCCESS")
			else
				text += "<br><font color='red'><B>The wizard has failed!</B></font>"
				SSblackbox.record_feedback("tally", "wizard_success", 1, "FAIL")
			if(wizard.spell_list)
				text += "<br><B>[wizard.name] used the following spells: </B>"
				var/i = 1
				for(var/obj/effect/proc_holder/spell/S in wizard.spell_list)
					text += "[S.name]"
					if(wizard.spell_list.len > i)
						text += ", "
					i++
			text += "<br>"

		return text.Join("")

//OTHER PROCS

//To batch-remove wizard spells. Linked to mind.dm
/mob/proc/spellremove(mob/M)
	if(!mind)
		return
	for(var/obj/effect/proc_holder/spell/spell_to_remove in mind.spell_list)
		qdel(spell_to_remove)
		mind.spell_list -= spell_to_remove

//To batch-remove mob spells.
/mob/proc/mobspellremove(mob/M)
	for(var/obj/effect/proc_holder/spell/spell_to_remove in mob_spell_list)
		qdel(spell_to_remove)
		mob_spell_list -= spell_to_remove

/*Checks if the wizard can cast spells.
Made a proc so this is not repeated 14 (or more) times.*/
/mob/proc/casting()
//Removed the stat check because not all spells require clothing now.
	if(!istype(usr:wear_suit, /obj/item/clothing/suit/wizrobe))
		to_chat(usr, "I don't feel strong enough without my robe.")
		return 0
	if(!istype(usr:shoes, /obj/item/clothing/shoes/sandal))
		to_chat(usr, "I don't feel strong enough without my sandals.")
		return 0
	if(!istype(usr:head, /obj/item/clothing/head/wizard))
		to_chat(usr, "I don't feel strong enough without my hat.")
		return 0
	else
		return 1

/proc/iswizard(mob/living/M as mob)
	return istype(M) && M.mind && SSticker && SSticker.mode && ((M.mind in SSticker.mode.wizards) || (M.mind in SSticker.mode.apprentices))
