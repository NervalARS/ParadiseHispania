/obj/item/clothing/head/helmet/riot/rangerh
	name = "Ranger security helmet"
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "riot_rangerw"
	item_state = "riot_rangerw"
	flags = BLOCKHAIR
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	hispania_icon = TRUE
	species_restricted = list("Human", "Slime", "Machine", "Kidan", "Skrell", "Diona" )

/obj/item/clothing/head/big_chungus
	name = "funny rabbit head"
	desc = "For some reason, seeing this fluffy helmet with its shit-grin smile and fat ears makes you fucking livid, as if you are embedded with the rage of one-thousand hells."
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "chungus"
	item_state = "chungus"
	flags = BLOCKHAIR
	hispania_icon = TRUE
	species_restricted = list("Human", "Slime", "Machine", "Kidan", "Skrell", "Diona" )

/obj/item/clothing/head/flowercrown
	name = "flower crown"
	icon_state = "flowercrown"
	desc = "Smells nice."
	item_state = "flowercrown"
	hispania_icon = TRUE

/obj/item/clothing/head/elzrahat
	name = "Lady Elzra's Priest Hat"
	desc = "A hat of made for Lady Elzra's Priests. Made by D&N corp."
	icon_state = "elzrahat"
	item_state = "elzrahat"
	strip_delay = 40
	hispania_icon = TRUE
	flags = BLOCKHEADHAIR

/obj/item/clothing/head/miter
	name = "Miter"
	desc = "A Miter used by Christian Bishops in celebrations. Made by D&N corp."
	icon_state = "miter"
	item_state = "miter"
	strip_delay = 40
	hispania_icon = TRUE

///Hispania Job Hats

/*Nota: todos los sprites que sean pertenecientes al code hispania y tengan sus
respectivos sprites en las carpetas de iconos de hispania , es decir modularHispania/icons/
deberan tener una linea de codigo demas para que funcionen "hispania_icon = TRUE"*/



//Captain formal hat by Danaleja
/obj/item/clothing/head/caphat/dark
	name = "captain's formal blue hat"
	desc = "A nice and formal hat made of silk, only for station captains. Made by D&N Corp."
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "caphat_dark"
	item_state = "caphat_dark"
	hispania_icon = TRUE
	species_restricted = list("exclude", "Grey", "Vox")

/obj/item/clothing/head/caphat/light
	name = "captain's formal white hat"
	desc = "A nice and formal hat made of silk, only for station captains. Made by D&N Corp."
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "caphat_light"
	item_state = "caphat_light"
	hispania_icon = TRUE
	species_restricted = list("exclude", "Grey", "Vox")

//Private Sec Berets (Danaleja2005)
/obj/item/clothing/head/beret/sec/private
	name = "blue security beret"
	desc = "A blue security beret, its have a badge of Security Department. Made by D&N Corp."
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "secberetprivateofficer_blue"
	item_state = "secberetprivateofficer_blue"
	hispania_icon = TRUE
	species_restricted = list("exclude", "Vox", "Grey")

/obj/item/clothing/head/beret/sec/private/red
	name = "red security beret"
	desc = "A red security beret, its have a badge of Security Department. Made by D&N Corp."
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "secberetprivateofficer_red"
	item_state = "secberetprivateofficer_red"
	hispania_icon = TRUE

/obj/item/clothing/head/officer/hat
	name = "officer's blue hat"
	desc = "A blue hat with a badge of Security Department. Made by D&N Corp."
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "sechat_blue"
	item_state = "sechat_blue"
	strip_delay = 80
	hispania_icon = TRUE
	species_restricted = list("exclude", "Grey")
	sprite_sheets = list(
		"Vox" = 'modularHispania/icons/mob/species/vox/head.dmi'
		)

/obj/item/clothing/head/officer/hat/red
	name = "officer's red hat"
	desc = "A red hat with a badge of Security Department."
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "sechat_red"
	item_state = "sechat_red"
	hispania_icon = TRUE

// Chaplain Hats

/obj/item/clothing/head/lady_elzra
	name = "Lady Elzra's Hat"
	desc = "a Lady Elzra's Hat worn by high religious priests of the order of the great lady (lady elzra) made of silk. Made by D&N Corp."
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "elzrahat"
	item_state = "elzrahat"
	strip_delay = 40
	hispania_icon = TRUE
	flags = BLOCKHEADHAIR
	species_restricted = list("exclude", "Grey")

/obj/item/clothing/head/miter
	name = "Bishop Miter"
	desc = "A miter used by Christian Bishops. Made by D&N Corp."
	icon = 'modularHispania/icons/mob/head.dmi'
	icon_state = "miter"
	item_state = "miter"
	strip_delay = 40
	hispania_icon = TRUE
	species_restricted = list("exclude", "Grey")
