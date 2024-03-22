	///Hispania Armors///

/*Nota: todos los sprites que sean pertenecientes al code hispania y tengan sus
respectivos sprites en las carpetas de iconos de hispania , es decir modularHispania/icons
deberan tener una linea de codigo demas para que funcionen "hispania_icon = TRUE"*/

//Code by Danaleja2005
/obj/item/clothing/suit/armor/vest/captrenchcoat
	name = "captain's trench coat"
	desc = "A special trenchcoat made with nanofibers of high resistance to melee, laser and projectile attacks, exclusive use for station captains. Made by D&N Corp"
	icon = 'modularHispania/icons/mob/suit.dmi'
	icon_state = "captain_trenchcoat"
	item_state = "captain_trenchcoat"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor = list("melee" = 50, "bullet" = 40, "laser" = 50, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 90)
	dog_fashion = null
	hispania_icon = TRUE
	resistance_flags = FIRE_PROOF
	species_restricted = list("exclude", "Grey", "Vox")

//Code by gingungangingungan
/obj/item/clothing/suit/armor/hos/ranger
	name = "armored security ranger"
	desc = "A riot armor used in desert operations, represent law and justice!."
	icon = 'modularHispania/icons/mob/suit.dmi'
	icon_state = "riot_rangerw2"
	item_state = "riot_rangerw2"
	flags_inv = 0
	ignore_suitadjust = 1
	hispania_icon = TRUE
	species_restricted = list("Human", "Slime", "Machine", "Kidan", "Skrell", "Diona" )

/obj/item/clothing/suit/hooded/armor
	name = "warden's armored winter coat"
	desc = "A heavy armored jacket made from 'synthetic' animal furs with silver rank pips and livery."
	icon = 'modularHispania/icons/obj/clothing/suits.dmi'
	lefthand_file = 'modularHispania/icons/mob/inhands/clothing_lefthand.dmi'
	righthand_file = 'modularHispania/icons/mob/inhands/clothing_righthand.dmi'
	icon_state = "wintercoat_warden"
	item_state = "wintercoat_warden"
	hispania_icon = TRUE
	allowed = list(/obj/item/gun/energy,/obj/item/reagent_containers/spray/pepper,/obj/item/gun/projectile,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/restraints/handcuffs,/obj/item/flashlight/seclite,/obj/item/melee/classic_baton/telescopic,/obj/item/kitchen/knife)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	cold_protection = UPPER_TORSO|LOWER_TORSO|HANDS
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = UPPER_TORSO|LOWER_TORSO|HANDS
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 35
	put_on_delay = 40
	max_integrity = 250
	flags_inv = HIDEJUMPSUIT
	resistance_flags = FLAMMABLE
	dog_fashion = null
	armor = list("melee" = 20, "bullet" = 20, "laser" = 20, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 25)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/warden
	sprite_sheets = list("Vox" = 'modularHispania/icons/mob/species/vox/suit.dmi')

/obj/item/clothing/suit/hooded/armor/hos
	name = "armored winter coat"
	desc = "A trench coat enhanced with a special alloy for some protection and style. Hood Included"
	icon_state = "wintercoat_hos"
	item_state = "wintercoat_hos"
	strip_delay = 40
	armor = list("melee" = 20, "bullet" = 20, "laser" = 20, "energy" = 5, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/warden/hos

/obj/item/clothing/suit/hooded/armor/detective
	name = "winter coat"
	desc = "An 18th-century multi-purpose winter trenchcoat. Someone who wears this means serious business."
	icon_state = "wintercoat_detective"
	item_state = "wintercoat_detective"
	blood_overlay_type = "coat"
	strip_delay = 30
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|HANDS
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|HANDS
	allowed = list(/obj/item/tank, /obj/item/reagent_containers/spray/pepper, /obj/item/flashlight, /obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/detective_scanner, /obj/item/taperecorder)
	armor = list("melee" = 15, "bullet" = 5, "laser" = 15, "energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 40)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/warden/detective

/obj/item/clothing/head/hooded/winterhood/security/warden
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "winterhood_warden"
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20, "energy" = 5, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 15)
	hispania_icon = TRUE
	sprite_sheets = list("Vox" = 'modularHispania/icons/mob/species/vox/head.dmi')

/obj/item/clothing/head/hooded/winterhood/security/warden/detective
	icon_state = "winterhood_detective"
	armor = list("melee" = 15, "bullet" = 5, "laser" = 15, "energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 15)

/obj/item/clothing/head/hooded/winterhood/security/warden/hos
	icon_state = "winterhood_hos"
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20, "energy" = 5, "bomb" = 15, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 15)

