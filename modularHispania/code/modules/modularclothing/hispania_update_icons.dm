/mob/living/carbon/human/update_inv_w_uniform()
	remove_overlay(UNIFORM_LAYER)
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_JUMPSUIT]
		if(inv)
			inv.update_icon()

	if(w_uniform && istype(w_uniform, /obj/item/clothing/under))
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)			//if the inventory is open ...
				w_uniform.screen_loc = ui_iclothing //...draw the item in the inventory screen
			client.screen += w_uniform				//Either way, add the item to the HUD

		var/t_color = w_uniform.item_color
		if(!t_color)
			t_color = icon_state

		var/mutable_appearance/standing = mutable_appearance(w_uniform.hispania_icon ? 'modularHispania/icons/mob/uniform.dmi' : 'icons/mob/clothing/under/misc.dmi', "[t_color]_s", layer = -UNIFORM_LAYER)
		if(w_uniform.icon_override)
			standing.icon = w_uniform.icon_override
		if(w_uniform.sprite_sheets)
			standing.icon = w_uniform.sprite_sheets["Human"]
			if(w_uniform.sprite_sheets[dna.species.sprite_sheet_name] && icon_exists(w_uniform.sprite_sheets[dna.species.sprite_sheet_name], "[t_color]_s"))
				standing.icon = w_uniform.sprite_sheets[dna.species.sprite_sheet_name]

		if(w_uniform.blood_DNA)
			var/image/bloodsies	= image("icon" = dna.species.blood_mask, "icon_state" = "uniformblood")
			bloodsies.color = w_uniform.blood_color
			standing.overlays += bloodsies

		if(w_uniform.accessories.len)	//WE CHECKED THE TYPE ABOVE. THIS REALLY SHOULD BE FINE. // oh my god kys whoever made this if statement jfc :gun:
			for(var/obj/item/clothing/accessory/A in w_uniform:accessories)
				var/tie_color = A.item_color
				if(!tie_color)
					tie_color = A.icon_state
				if(A.icon_override)
					standing.overlays += image("icon" = A.icon_override, "icon_state" = "[A.icon_state]")
				else if(A.sprite_sheets && A.sprite_sheets[dna.species.sprite_sheet_name])
					standing.overlays += image("icon" = A.sprite_sheets[dna.species.sprite_sheet_name], "icon_state" = "[A.icon_state]")
				else
					standing.overlays += image("icon" = A.hispania_icon ? 'modularHispania/icons/mob/ties.dmi' : 'icons/mob/ties.dmi', "icon_state" = "[tie_color]")
		standing.alpha = w_uniform.alpha
		standing.color = w_uniform.color
		overlays_standing[UNIFORM_LAYER] = standing

	else if(!dna.species.nojumpsuit)
		var/list/uniform_slots = list()
		var/obj/item/organ/external/L = get_organ(BODY_ZONE_L_LEG)
		if(!(L?.status & ORGAN_ROBOT))
			uniform_slots += l_store
		var/obj/item/organ/external/R = get_organ(BODY_ZONE_R_LEG)
		if(!(R?.status & ORGAN_ROBOT))
			uniform_slots += r_store
		var/obj/item/organ/external/C = get_organ(BODY_ZONE_CHEST)
		if(!(C?.status & ORGAN_ROBOT))
			uniform_slots += wear_id
			uniform_slots += wear_pda
			uniform_slots += belt
		if(belt && (belt.flags_2 & ALLOW_BELT_NO_JUMPSUIT_2))
			uniform_slots -= belt

		// Automatically drop anything in store / id / belt if you're not wearing a uniform.	//CHECK IF NECESARRY
		for(var/obj/item/thing in uniform_slots)												// whoever made this
			if(thing)																			// you're a piece of fucking garbage
				unEquip(thing)																	// why the fuck would you goddamn do this motherfucking shit
				if(client)																		// INVENTORY CODE IN FUCKING ICON CODE
					client.screen -= thing														// WHAT THE FUCKING FUCK BAY GODDAMNIT
																								// **I FUCKING HATE YOU AAAAAAAAAA**
				if(thing)																		//
					thing.forceMove(drop_location())											//
					thing.dropped(src)															//
					thing.layer = initial(thing.layer)
					thing.plane = initial(thing.plane)
	apply_overlay(UNIFORM_LAYER)
	update_hands_layer()

/mob/living/carbon/human/update_inv_wear_id()
	remove_overlay(ID_LAYER)
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_WEAR_ID]
		if(inv)
			inv.update_icon()

	if(wear_id)
		if(client && hud_used && hud_used.hud_shown)
			wear_id.screen_loc = ui_id
			client.screen += wear_id

		if(w_uniform && w_uniform:displays_id)
			overlays_standing[ID_LAYER]	= mutable_appearance('icons/mob/mob.dmi', "id", layer = -ID_LAYER)
	apply_overlay(ID_LAYER)

/mob/living/carbon/human/update_inv_gloves()
	remove_overlay(GLOVES_LAYER)
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_GLOVES]
		if(inv)
			inv.update_icon()

	if(gloves)
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)			//if the inventory is open ...
				gloves.screen_loc = ui_gloves		//...draw the item in the inventory screen
			client.screen += gloves					//Either way, add the item to the HUD

		var/t_state = gloves.item_state
		if(!t_state)	t_state = gloves.icon_state

		var/mutable_appearance/standing
		if(gloves.icon_override)
			standing = mutable_appearance(gloves.icon_override, "[gloves.icon_state]", layer = -GLOVES_LAYER)
		else if(gloves.sprite_sheets && gloves.sprite_sheets[dna.species.sprite_sheet_name])
			standing = mutable_appearance(gloves.sprite_sheets[dna.species.sprite_sheet_name], "[t_state]", layer = -GLOVES_LAYER)
		else
			standing = mutable_appearance(gloves.hispania_icon ? 'modularHispania/icons/mob/hands.dmi' : 'icons/mob/clothing/hands.dmi', "[t_state]", layer = -GLOVES_LAYER)

		if(gloves.blood_DNA)
			var/image/bloodsies	= image("icon" = dna.species.blood_mask, "icon_state" = "bloodyhands")
			bloodsies.color = gloves.blood_color
			standing.overlays += bloodsies
		overlays_standing[GLOVES_LAYER]	= standing
	else
		if(blood_DNA)
			var/mutable_appearance/bloodsies = mutable_appearance(dna.species.blood_mask, "bloodyhands", layer = -GLOVES_LAYER)
			bloodsies.color = hand_blood_color
			overlays_standing[GLOVES_LAYER]	= bloodsies
	apply_overlay(GLOVES_LAYER)


/mob/living/carbon/human/update_inv_glasses()
	remove_overlay(GLASSES_LAYER)
	remove_overlay(GLASSES_OVER_LAYER)
	remove_overlay(OVER_MASK_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_GLASSES]
		if(inv)
			inv.update_icon()

	if(glasses)
		var/mutable_appearance/new_glasses
		var/obj/item/organ/external/head/head_organ = get_organ("head")
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)			//if the inventory is open ...
				glasses.screen_loc = ui_glasses		//...draw the item in the inventory screen
			client.screen += glasses				//Either way, add the item to the HUD

		if(glasses.icon_override)
			new_glasses = mutable_appearance(glasses.icon_override, "[glasses.icon_state]", layer = -GLASSES_LAYER)
		else if(glasses.sprite_sheets && glasses.sprite_sheets[head_organ.dna.species.sprite_sheet_name])
			new_glasses = mutable_appearance(glasses.sprite_sheets[head_organ.dna.species.sprite_sheet_name], "[glasses.icon_state]", layer = -GLASSES_LAYER)
		else
			new_glasses = mutable_appearance(glasses.hispania_icon ? 'modularHispania/icons/mob/eyes.dmi' : 'icons/mob/clothing/eyes.dmi', "[glasses.icon_state]", layer = -GLASSES_LAYER)

		var/datum/sprite_accessory/hair/hair_style = GLOB.hair_styles_full_list[head_organ.h_style]
		var/obj/item/clothing/glasses/G = glasses
		if(istype(G) && G.over_mask) //If the user's used the 'wear over mask' verb on the glasses.
			new_glasses.layer = -OVER_MASK_LAYER
			overlays_standing[OVER_MASK_LAYER] = new_glasses
			apply_overlay(OVER_MASK_LAYER)
		else if(hair_style && hair_style.glasses_over) //Select which layer to use based on the properties of the hair style. Hair styles with hair that don't overhang the arms of the glasses should have glasses_over set to a positive value.
			new_glasses.layer = -GLASSES_OVER_LAYER
			overlays_standing[GLASSES_OVER_LAYER] = new_glasses
			apply_overlay(GLASSES_OVER_LAYER)
		else
			overlays_standing[GLASSES_LAYER] = new_glasses
			apply_overlay(GLASSES_LAYER)

	update_misc_effects()

/mob/living/carbon/human/update_inv_ears()
	remove_overlay(EARS_LAYER)
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_LEFT_EAR]
		if(inv)
			inv.update_icon()

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_RIGHT_EAR]
		if(inv)
			inv.update_icon()

	if(l_ear || r_ear)
		if(l_ear)
			if(client && hud_used && hud_used.hud_shown)
				if(hud_used.inventory_shown)			//if the inventory is open ...
					l_ear.screen_loc = ui_l_ear			//...draw the item in the inventory screen
				client.screen += l_ear					//Either way, add the item to the HUD

			var/t_type = l_ear.item_state
			if(!t_type)
				t_type = l_ear.icon_state
			if(l_ear.icon_override)
				t_type = "[t_type]_l"
				overlays_standing[EARS_LAYER] = mutable_appearance(l_ear.icon_override, "[t_type]", layer = -EARS_LAYER)
			else if(l_ear.sprite_sheets && l_ear.sprite_sheets[dna.species.sprite_sheet_name])
				overlays_standing[EARS_LAYER] = mutable_appearance(l_ear.sprite_sheets[dna.species.sprite_sheet_name], "[t_type]", layer = -EARS_LAYER)
			else
				overlays_standing[EARS_LAYER] = mutable_appearance(l_ear.hispania_icon ? 'modularHispania/icons/mob/ears.dmi' : 'icons/mob/clothing/ears.dmi', "[t_type]", layer = -EARS_LAYER)

		if(r_ear)
			if(client && hud_used && hud_used.hud_shown)
				if(hud_used.inventory_shown)			//if the inventory is open ...
					r_ear.screen_loc = ui_r_ear			//...draw the item in the inventory screen
				client.screen += r_ear					//Either way, add the item to the HUD

			var/t_type = r_ear.item_state
			if(!t_type)
				t_type = r_ear.icon_state
			if(r_ear.icon_override)
				t_type = "[t_type]_r"
				overlays_standing[EARS_LAYER] = mutable_appearance(r_ear.icon_override, "[t_type]", layer = -EARS_LAYER)
			else if(r_ear.sprite_sheets && r_ear.sprite_sheets[dna.species.sprite_sheet_name])
				overlays_standing[EARS_LAYER] = mutable_appearance(r_ear.sprite_sheets[dna.species.sprite_sheet_name], "[t_type]", layer = -EARS_LAYER)
			else
				overlays_standing[EARS_LAYER] = mutable_appearance(r_ear.hispania_icon ? 'modularHispania/icons/mob/ears.dmi' : 'icons/mob/clothing/ears.dmi', "[t_type]", layer = -EARS_LAYER)
	apply_overlay(EARS_LAYER)

/mob/living/carbon/human/update_inv_shoes()
	remove_overlay(SHOES_LAYER)
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_SHOES]
		if(inv)
			inv.update_icon()

	if(shoes)
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)			//if the inventory is open ...
				shoes.screen_loc = ui_shoes			//...draw the item in the inventory screen
			client.screen += shoes					//Either way, add the item to the HUD

		if(!wear_suit || !(wear_suit.flags_inv & HIDESHOES))
			var/mutable_appearance/standing
			if(shoes.icon_override)
				standing = mutable_appearance(shoes.icon_override, "[shoes.icon_state]", layer = -SHOES_LAYER)
			else if(shoes.sprite_sheets && shoes.sprite_sheets[dna.species.sprite_sheet_name])
				standing = mutable_appearance(shoes.sprite_sheets[dna.species.sprite_sheet_name], "[shoes.icon_state]", layer = -SHOES_LAYER)
			else
				standing = mutable_appearance(shoes.hispania_icon ? 'modularHispania/icons/mob/feet.dmi' : 'icons/mob/clothing/feet.dmi', "[shoes.icon_state]", layer = -SHOES_LAYER)

			if(shoes.blood_DNA)
				var/image/bloodsies = image("icon" = dna.species.blood_mask, "icon_state" = "shoeblood")
				bloodsies.color = shoes.blood_color
				standing.overlays += bloodsies
			standing.alpha = shoes.alpha
			standing.color = shoes.color
			overlays_standing[SHOES_LAYER] = standing
	else
		if(feet_blood_DNA)
			var/mutable_appearance/bloodsies = mutable_appearance(dna.species.blood_mask, "shoeblood", layer = -SHOES_LAYER)
			bloodsies.color = feet_blood_color
			overlays_standing[SHOES_LAYER] = bloodsies
	apply_overlay(SHOES_LAYER)

/mob/living/carbon/human/update_inv_s_store()
	remove_overlay(SUIT_STORE_LAYER)
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_SUIT_STORE]
		if(inv)
			inv.update_icon()

	if(s_store)
		if(client && hud_used && hud_used.hud_shown)
			s_store.screen_loc = ui_sstore1
			client.screen += s_store

		var/t_state = s_store.item_state
		if(!t_state)
			t_state = s_store.icon_state
		var/dmi='icons/mob/clothing/belt_mirror.dmi'
		overlays_standing[SUIT_STORE_LAYER] = mutable_appearance(dmi, "[t_state]", layer = -SUIT_STORE_LAYER)
		s_store.screen_loc = ui_sstore1		//TODO
	apply_overlay(SUIT_STORE_LAYER)


/mob/living/carbon/human/update_inv_head()
	..()
	remove_overlay(HEAD_LAYER)
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_HEAD]
		if(inv)
			inv.update_icon()

	if(head)
		var/mutable_appearance/standing
		if(head.icon_override)
			standing = mutable_appearance(head.icon_override, "[head.icon_state]", layer = -HEAD_LAYER)
		else if(head.sprite_sheets && head.sprite_sheets[dna.species.sprite_sheet_name])
			standing = mutable_appearance(head.sprite_sheets[dna.species.sprite_sheet_name], "[head.icon_state]", layer = -HEAD_LAYER)
			if(istype(head, /obj/item/clothing/head/helmet/space/plasmaman))
				var/obj/item/clothing/head/helmet/space/plasmaman/P = head
				if(!P.up)
					standing.overlays += P.visor_icon
		else
			standing = mutable_appearance(head.hispania_icon ? 'modularHispania/icons/mob/head.dmi' : 'icons/mob/clothing/head.dmi', "[head.icon_state]", layer = -HEAD_LAYER)

		if(head.blood_DNA)
			var/image/bloodsies = image("icon" = dna.species.blood_mask, "icon_state" = "helmetblood")
			bloodsies.color = head.blood_color
			standing.overlays += bloodsies
		standing.alpha = head.alpha
		standing.color = head.color
		overlays_standing[HEAD_LAYER] = standing
	apply_overlay(HEAD_LAYER)

/mob/living/carbon/human/update_inv_belt()
	remove_overlay(BELT_LAYER)
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_BELT]
		if(inv)
			inv.update_icon()

		if(hud_used.hud_shown && belt)
			client.screen += belt
			belt.screen_loc = ui_belt

	if(belt)
		var/t_state = belt.item_state
		if(!t_state)
			t_state = belt.icon_state

		if(belt.icon_override)
			t_state = "[t_state]_be"
			overlays_standing[BELT_LAYER] = mutable_appearance(belt.icon_override, "[t_state]", layer = -BELT_LAYER)
		else if(belt.sprite_sheets && belt.sprite_sheets[dna.species.sprite_sheet_name])
			overlays_standing[BELT_LAYER] = mutable_appearance(belt.sprite_sheets[dna.species.sprite_sheet_name], "[t_state]", layer = -BELT_LAYER)
		else
			overlays_standing[BELT_LAYER] = mutable_appearance(belt.hispania_icon ? 'modularHispania/icons/mob/belt.dmi' : 'icons/mob/clothing/belt.dmi', "[t_state]", layer = -BELT_LAYER)
	apply_overlay(BELT_LAYER)


/mob/living/carbon/human/update_inv_wear_suit()
	remove_overlay(SUIT_LAYER)
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_OUTER_SUIT]
		if(inv)
			inv.update_icon()

	if(wear_suit && istype(wear_suit, /obj/item/clothing/suit))
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)					//if the inventory is open ...
				wear_suit.screen_loc = ui_oclothing	//TODO	//...draw the item in the inventory screen
			client.screen += wear_suit						//Either way, add the item to the HUD

		var/mutable_appearance/standing
		if(wear_suit.icon_override)
			standing = mutable_appearance(wear_suit.icon_override, "[wear_suit.icon_state]", layer = -SUIT_LAYER)
		else if(wear_suit.sprite_sheets && wear_suit.sprite_sheets[dna.species.sprite_sheet_name])
			standing = mutable_appearance(wear_suit.sprite_sheets[dna.species.sprite_sheet_name], "[wear_suit.icon_state]", layer = -SUIT_LAYER)
		else
			standing = mutable_appearance(wear_suit.hispania_icon ? 'modularHispania/icons/mob/suit.dmi' : 'icons/mob/clothing/suit.dmi', "[wear_suit.icon_state]", layer = -SUIT_LAYER)

		if(wear_suit.breakouttime)
			drop_l_hand()
			drop_r_hand()

		if(wear_suit.blood_DNA)
			var/obj/item/clothing/suit/S = wear_suit
			var/image/bloodsies = image("icon" = dna.species.blood_mask, "icon_state" = "[S.blood_overlay_type]blood")
			bloodsies.color = wear_suit.blood_color
			standing.overlays += bloodsies


		var/special_overlays = wear_suit.special_overlays()
		if(special_overlays)
			standing.overlays += special_overlays

		standing.alpha = wear_suit.alpha
		standing.color = wear_suit.color
		overlays_standing[SUIT_LAYER] = standing

	apply_overlay(SUIT_LAYER)
	update_tail_layer()
	update_wing_layer()
	update_collar()

/mob/living/carbon/human/update_inv_pockets()
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv

		inv = hud_used.inv_slots[SLOT_HUD_LEFT_STORE]
		if(inv)
			inv.update_icon()

		inv = hud_used.inv_slots[SLOT_HUD_RIGHT_STORE]
		if(inv)
			inv.update_icon()

		if(hud_used.hud_shown)
			if(l_store)
				client.screen += l_store
				l_store.screen_loc = ui_storage1

			if(r_store)
				client.screen += r_store
				r_store.screen_loc = ui_storage2

/mob/living/carbon/human/update_inv_wear_pda()
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_WEAR_PDA]
		if(inv)
			inv.update_icon()

		if(wear_pda)
			client.screen += wear_pda
			wear_pda.screen_loc = ui_pda

/mob/living/carbon/human/update_inv_wear_mask()
	..()
	remove_overlay(FACEMASK_LAYER)
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[SLOT_HUD_WEAR_MASK]
		if(inv)
			inv.update_icon()
	if(wear_mask && (istype(wear_mask, /obj/item/clothing/mask) || istype(wear_mask, /obj/item/clothing/accessory)))
		if(!(SLOT_HUD_WEAR_MASK in check_obscured_slots()))
			var/obj/item/organ/external/head/head_organ = get_organ("head")
			if(!istype(head_organ))
				return // Nothing to update here
			var/datum/sprite_accessory/alt_heads/alternate_head
			if(head_organ.alt_head && head_organ.alt_head != "None")
				alternate_head = GLOB.alt_heads_list[head_organ.alt_head]

			var/mutable_appearance/standing
			var/icon/mask_icon = new(wear_mask.icon)
			if(wear_mask.icon_override)
				mask_icon = new(wear_mask.icon_override)
				standing = mutable_appearance(wear_mask.icon_override, "[wear_mask.icon_state][(alternate_head && ("[wear_mask.icon_state]_[alternate_head.suffix]" in mask_icon.IconStates())) ? "_[alternate_head.suffix]" : ""]", layer = -FACEMASK_LAYER)
			else if(wear_mask.sprite_sheets && wear_mask.sprite_sheets[dna.species.sprite_sheet_name])
				mask_icon = new(wear_mask.sprite_sheets[dna.species.sprite_sheet_name])
				standing = mutable_appearance(wear_mask.sprite_sheets[dna.species.sprite_sheet_name], "[wear_mask.icon_state][(alternate_head && ("[wear_mask.icon_state]_[alternate_head.suffix]" in mask_icon.IconStates())) ? "_[alternate_head.suffix]" : ""]", layer = -FACEMASK_LAYER)
			else
				standing = mutable_appearance(wear_mask.hispania_icon ? 'modularHispania/icons/mob/mask.dmi' : 'icons/mob/clothing/mask.dmi', "[wear_mask.icon_state][(alternate_head && ("[wear_mask.icon_state]_[alternate_head.suffix]" in mask_icon.IconStates())) ? "_[alternate_head.suffix]" : ""]", layer = -FACEMASK_LAYER)

			if(!istype(wear_mask, /obj/item/clothing/mask/cigarette) && wear_mask.blood_DNA)
				var/image/bloodsies = image("icon" = dna.species.blood_mask, "icon_state" = "maskblood")
				bloodsies.color = wear_mask.blood_color
				standing.overlays += bloodsies

			standing.alpha = wear_mask.alpha
			standing.color = wear_mask.color
			overlays_standing[FACEMASK_LAYER] = standing
	apply_overlay(FACEMASK_LAYER)


/mob/living/carbon/human/update_inv_back()
	..()
	remove_overlay(BACK_LAYER)
	if(back)
		//determine the icon to use
		var/t_state = back.item_state
		if(!t_state)
			t_state = back.icon_state
		var/mutable_appearance/standing
		if(back.icon_override)
			standing = mutable_appearance(back.icon_override, "[back.icon_state]", layer = -BACK_LAYER)
		else if(back.sprite_sheets && back.sprite_sheets[dna.species.sprite_sheet_name])
			standing = mutable_appearance(back.sprite_sheets[dna.species.sprite_sheet_name], "[t_state]", layer = -BACK_LAYER)
		else
			standing = mutable_appearance(back.hispania_icon ? 'modularHispania/icons/mob/back.dmi' : 'icons/mob/clothing/back.dmi', "[t_state]", layer = -BACK_LAYER)

		//create the image
		standing.alpha = back.alpha
		standing.color = back.color
		overlays_standing[BACK_LAYER] = standing
	apply_overlay(BACK_LAYER)

/mob/living/carbon/human/update_inv_handcuffed()
	remove_overlay(HANDCUFF_LAYER)
	if(handcuffed)
		overlays_standing[HANDCUFF_LAYER] = mutable_appearance('icons/mob/mob.dmi', handcuffed.cuffed_state, layer = -HANDCUFF_LAYER, color = handcuffed.color)
	apply_overlay(HANDCUFF_LAYER)

/mob/living/carbon/human/update_inv_legcuffed()
	remove_overlay(LEGCUFF_LAYER)
	. = ..()
	if(legcuffed)
		overlays_standing[LEGCUFF_LAYER] = mutable_appearance('icons/mob/mob.dmi', legcuffed.cuffed_state, layer = -LEGCUFF_LAYER)
	apply_overlay(LEGCUFF_LAYER)


/mob/living/carbon/human/update_inv_r_hand()
	..()
	remove_overlay(R_HAND_LAYER)
	if(r_hand)
		var/t_state = r_hand.item_state
		if(!t_state)
			t_state = r_hand.icon_state

		var/mutable_appearance/standing
		if(r_hand.sprite_sheets_inhand && r_hand.sprite_sheets_inhand[dna.species.sprite_sheet_name])
			t_state = "[t_state]_r"
			standing = mutable_appearance(r_hand.sprite_sheets_inhand[dna.species.sprite_sheet_name], "[t_state]", layer = -R_HAND_LAYER, color = r_hand.color)
		else
			standing = mutable_appearance(r_hand.righthand_file, "[t_state]", layer = -R_HAND_LAYER, color = r_hand.color)
			standing = center_image(standing, r_hand.inhand_x_dimension, r_hand.inhand_y_dimension)
		overlays_standing[R_HAND_LAYER] = standing
	apply_overlay(R_HAND_LAYER)


/mob/living/carbon/human/update_inv_l_hand()
	..()
	remove_overlay(L_HAND_LAYER)
	if(l_hand)
		var/t_state = l_hand.item_state
		if(!t_state)
			t_state = l_hand.icon_state

		var/mutable_appearance/standing
		if(l_hand.sprite_sheets_inhand && l_hand.sprite_sheets_inhand[dna.species.sprite_sheet_name])
			t_state = "[t_state]_l"
			standing = mutable_appearance(l_hand.sprite_sheets_inhand[dna.species.sprite_sheet_name], "[t_state]", layer = -L_HAND_LAYER, color = l_hand.color)
		else
			standing = mutable_appearance(l_hand.lefthand_file, "[t_state]", layer = -L_HAND_LAYER, color = l_hand.color)
			standing = center_image(standing, l_hand.inhand_x_dimension, l_hand.inhand_y_dimension)
		overlays_standing[L_HAND_LAYER] = standing
	apply_overlay(L_HAND_LAYER)
