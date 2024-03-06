/obj/effect/proc_holder/spell/clown/pie_cannon 			//pie cannon spell
	name = "Deploy pie cannon"
	desc = "Activate to deploy your very own auto-recharging pie cannon."
	school = "clown"
	panel = "Clown"
	clothes_req = FALSE
	base_cooldown = 20 SECONDS
	human_req = TRUE
	action_icon_state = "bolt_action"
	action_background_icon_state = "bg_default"
	var/gun = /obj/item/gun/throw/piecannon/auto_piecannon

/obj/effect/proc_holder/spell/clown/create_new_targeting()
	return new /datum/spell_targeting/self

/obj/effect/proc_holder/spell/clown/pie_cannon/cast(list/targets, mob/user = usr)
	for(var/mob/living/carbon/human/C in targets)
		if(!istype(C.get_active_hand(), gun) && !istype(C.get_inactive_hand(), gun))
			to_chat(user, "<span class='notice'>You draw your pie cannon!</span>")
			C.drop_item()
			C.put_in_hands(new gun)
			playsound(user, 'sound/weapons/gun_interactions/shotgunpump.ogg', 50)
		else
			to_chat(user, "<span class='notice'>Holster your pie cannon first.</span>")
			revert_cast(user)

//empieza el lube floor spell
/obj/effect/proc_holder/spell/clown/floor_lube
	name = "Floor lube"
	desc = "Activate to create a barrier of spacelube below your feet, CAREFUL VERY SLIPPERY."
	school = "clown"
	panel = "Clown"
	clothes_req = FALSE
	base_cooldown = 12 SECONDS
	human_req = TRUE
	action_icon_state = "set_drop"
	action_background_icon_state = "bg_default"

/obj/effect/proc_holder/spell/clown/floor_lube/create_new_targeting()
	return new /datum/spell_targeting/self

/obj/effect/proc_holder/spell/clown/floor_lube/cast(list/targets, mob/user = usr)
	if(user.dir == SOUTH || user.dir == NORTH)
		for(var/turf/simulated/floor/O in range("3x1", usr))
			O.MakeSlippery(TURF_WET_LUBE, 20 SECONDS)
	else
		for(var/turf/simulated/floor/O in range("1x3", usr))
			O.MakeSlippery(TURF_WET_LUBE, 20 SECONDS)

//empieza Funny button
/obj/effect/proc_holder/spell/clown/funny_button
	name = "Laughs-on-demand"
	desc = "Conjure laughs from another dimension and channel them into humilliating your peers."
	action_icon_state = "hysteria"
	action_background_icon_state = "bg_default"
	school = "clown"
	panel = "Clown"
	clothes_req = FALSE
	base_cooldown = 3 SECONDS
	human_req = TRUE

/obj/effect/proc_holder/spell/clown/funny_button/create_new_targeting()
	return new /datum/spell_targeting/self

/obj/effect/proc_holder/spell/clown/funny_button/cast(list/targets, mob/user = usr)
	playsound(user.loc, 'modularHispania/sound/effects/sitcomlaugh.ogg', 550, 1)

///Empieza el spellbook
/obj/item/spellbook/oneuse/clown
	spellname = "Advanced Clowning"
	name = "Tome of: "
	desc = "Dripping with goo and smelling like bananas this compendium of forbidden clowning arts gives you an unsettling feeling. MIMES STAY AWAY."
	icon = 'modularHispania/icons/obj/library_hispania.dmi'
	icon_state = "clownbook"
	var/ash_type = /obj/effect/decal/cleanable/ash

/obj/item/spellbook/oneuse/clown/attack_self(mob/user)
	if(usr.mind.miming)		//placeholder for something bad if user has vow of silence.
		to_chat(user, "<span class='boldannounce'>Your instinct starts yelling at you that this will end horribly! YOU SHOULD STOP, NOW!</span>")
		if(do_after(usr, 150, target = usr))
			usr.gib()
	else
		var/obj/effect/proc_holder/spell/S = new spell
		for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
			if(knownspell.type == S.type)
				if(user.mind)
					to_chat(user, "<span class='notice'>You've already read this one.</span>")
				return
		if(used)
			recoil(user)
		else
			user.mind.AddSpell(new /obj/effect/proc_holder/spell/clown/pie_cannon(null))
			user.mind.AddSpell(new /obj/effect/proc_holder/spell/clown/floor_lube(null))
			user.mind.AddSpell(new /obj/effect/proc_holder/spell/clown/funny_button(null))
			to_chat(user, "<span class='warning'>As soon as you open the book images of the HonkMother start flashing inside your mind.. So beautiful.</span>")
			user.create_log(MISC_LOG, "learned the spell [spellname] ([S])")
			user.create_attack_log("<font color='orange'>[key_name(user)] learned the spell [spellname] ([S]).</font>")
			onlearned(user)

/obj/item/spellbook/oneuse/clown/recoil(mob/user)
	to_chat(user, "<span class='notice'>You flip through the pages. Nothing of interest to you.</span>")

/obj/item/spellbook/oneuse/clown/onlearned(mob/user)
	used = TRUE
	user.drop_item()
	new ash_type((get_turf(src)))
	qdel(src)
