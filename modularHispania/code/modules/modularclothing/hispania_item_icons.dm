/obj/item

	var/hispania_icon = FALSE

/obj/item/Initialize()
	..()

	icon = (hispania_icon ? 'modularHispania/icons/obj/items.dmi' : icon)
	lefthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/items_lefthand.dmi' : lefthand_file)
	righthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/items_righthand.dmi' : righthand_file)

/obj/item/clothing/glasses/Initialize()
	..()
	icon = (hispania_icon ? 'modularHispania/icons/obj/clothing/glasses.dmi' : icon)
	lefthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_lefthand.dmi' : lefthand_file)
	righthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_righthand.dmi' : righthand_file)

/obj/item/clothing/gloves/Initialize()
	..()
	icon = (hispania_icon ? 'modularHispania/icons/obj/clothing/gloves.dmi' : icon)
	lefthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_lefthand.dmi' : lefthand_file)
	righthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_righthand.dmi' : righthand_file)

/obj/item/clothing/head/Initialize()
	..()
	icon = (hispania_icon ? 'modularHispania/icons/obj/clothing/hats.dmi' : icon)
	lefthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_lefthand.dmi' : lefthand_file)
	righthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_righthand.dmi' : righthand_file)

/obj/item/clothing/mask/Initialize()
	..()
	icon = (hispania_icon ? 'modularHispania/icons/obj/clothing/masks.dmi' : icon)
	lefthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_lefthand.dmi' : lefthand_file)
	righthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_righthand.dmi' : righthand_file)

/obj/item/clothing/shoes/Initialize()
	..()
	icon = (hispania_icon ? 'modularHispania/icons/obj/clothing/shoes.dmi' : icon)
	lefthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_lefthand.dmi' : lefthand_file)
	righthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_righthand.dmi' : righthand_file)

/obj/item/clothing/suit/Initialize()
	..()
	icon = (hispania_icon ? 'modularHispania/icons/obj/clothing/suits.dmi' : icon)
	lefthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_lefthand.dmi' : lefthand_file)
	righthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_righthand.dmi' : righthand_file)

/obj/item/clothing/under/Initialize()
	..()
	icon = (hispania_icon ? 'modularHispania/icons/obj/clothing/uniforms.dmi' : icon)
	lefthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_lefthand.dmi' : lefthand_file)
	righthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/clothing_righthand.dmi' : righthand_file)

/obj/item/reagent_containers/food/snacks/grown/Initialize(mapload, obj/item/seeds/new_seed = null)
	. = ..()

	icon = (hispania_icon ? 'modularHispania/icons/obj/hydroponics/harvest.dmi' : icon)

/obj/item/seeds/Initialize()
	..()

	icon = (hispania_icon ? 'modularHispania/icons/obj/hydroponics/seeds.dmi' : icon)
	growing_icon = (hispania_icon ? 'modularHispania/icons/obj/hydroponics/growing.dmi' : growing_icon)

/obj/item/gun/Initialize()
	. = ..()

	icon = (hispania_icon ? 'modularHispania/icons/obj/guns/projectile.dmi' : icon)
	lefthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/guns_lefthand.dmi' : lefthand_file)
	righthand_file = (hispania_icon ? 'modularHispania/icons/mob/inhands/guns_righthand.dmi' : righthand_file)
