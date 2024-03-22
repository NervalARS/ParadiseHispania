///Hispania Civilians Clothes

// Captain Formal uniform by Danaleja
/obj/item/clothing/under/rank/command/captain/formal/dark
	name = "captain's formal blue uniform"
	desc = "A nice and formal uniform made of silk, only for station captains. Made by D&N Corp."
	icon = 'modularHispania/icons/mob/uniform.dmi'
	icon_state = "captain_dark"
	item_state = "captain_dark_s"
	item_color = "captain_dark"
	hispania_icon = TRUE
	species_restricted = list("exclude", "Grey", "Vox")

/obj/item/clothing/under/rank/command/captain/formal/light
	name = "captain's formal white uniform"
	desc = "A nice and formal uniform made of silk, only for station captains. Made by D&N Corp."
	icon = 'modularHispania/icons/mob/uniform.dmi'
	icon_state = "captain_light"
	item_state = "captain_light_s"
	item_color = "captain_light"
	hispania_icon = TRUE
	species_restricted = list("exclude", "Grey", "Vox")

/obj/item/clothing/under/rank/chaplain/elzra
	name = "Elzra's Acolyte Robes"
	desc = "A long acolyte robes for the high religious priests of the order of the great lady (lady elzra) made of silk. Made by D&N Corp."
	icon_state = "elzramale"
	item_state = "elzramale"
	item_color = "elzramale"
	hispania_icon = TRUE
	species_restricted = list("exclude", "Grey", "Vox")

/obj/item/clothing/under/rank/chaplain/elzra/female
	name = "Elzra's Acolyte Female Robes"
	desc = "A female long acolyte robes for high religious priests of the order of the great lady (lady elzra) made of silk, it have a small ruby on it. Made by D&N Corp."
	icon_state = "elzrafem"
	item_state = "elzrafem"
	item_color = "elzrafem"

/obj/item/clothing/under/rank/chaplain/alt
	name = "Priest's Uniform"
	icon = 'modularHispania/icons/mob/uniform.dmi'
	desc = "A set of special shirt, pants and clergyman worn by priests. Made by D&N Corp."
	icon_state = "chapalt"
	item_state = "chapalt"
	item_color = "chapalt"
	species_restricted = list("exclude", "Grey", "Vox")
	hispania_icon = TRUE

/obj/item/clothing/under/rank/chaplain/alt/blue
	name = "Priest's Blue Uniform"
	desc = "A set of special shirt, pants and clergyman worn by priests. Made by D&N Corp."
	icon_state = "chapaltblue"
	item_state = "chapaltblue"
	item_color = "chapaltblue"

/obj/item/clothing/under/rank/chaplain/cassock
	name = "Cassock"
	desc = "a long black garment worn by christian priests. Made by D&N Corp."
	icon_state = "cassock"
	item_state = "cassock"
	item_color = "cassock"
	species_restricted = list("exclude", "Grey", "Vox")
	hispania_icon = TRUE

//MISC CIVILIAN CLOTHES
/obj/item/clothing/under/bunnysuit
	name = "Black Bunny Suit"
	icon = 'modularHispania/icons/mob/uniform.dmi'
	icon_state = "bunnysuit"
	item_state = "bunnysuit"
	item_color = "bunnysuit"
	desc = "A sexy bunny suit, it is black. Made by KCompanies and distributed by D&N."
	hispania_icon = TRUE
	species_restricted = list("exclude", "Grey", "Vox")


/obj/item/clothing/under/bunnysuit/red
	name = "Red Bunny Suit"
	icon = 'modularHispania/icons/mob/uniform.dmi'
	icon_state = "bunnysuitred"
	item_state = "bunnysuitred"
	item_color = "bunnysuitred"
	desc = "A sexy bunny suit, it is red. Made by KCompanies and distributed by D&N."
	hispania_icon = TRUE
	species_restricted = list("exclude", "Grey", "Vox")

///Hispania Security Department Clothes

//Security Formal Uniform and Formal Pod Pilot's jumpsuit (Danaleja2005)
/obj/item/clothing/under/rank/security/private
	name = "formal blue security officer's uniform"
	desc = "A formal security officer's uniform, it has a logo that says 'Security Department'. Made by D&N Corp."
	icon = 'modularHispania/icons/mob/uniform.dmi'
	icon_state = "oficialblue"
	item_color = "oficialblue"
	hispania_icon = TRUE
	sprite_sheets = list(
		"Vox" = 'modularHispania/icons/mob/species/vox/uniform.dmi',
		"Grey" = 'modularHispania/icons/mob/species/grey/uniform.dmi'
		)

/obj/item/clothing/under/rank/security/private/red
	name = "formal red security officer's uniform"
	icon_state = "oficialred"
	item_color = "oficialred"
///Hispania MedSci Department Clothes

/*Nota: todos los sprites que sean pertenecientes al code hispania y tengan sus
respectivos sprites en las carpetas de iconos de hispania , es decir modularHispania/icons
deberan tener una linea de codigo demas para que funcionen "hispania_icon = TRUE"*/

//Resprite of RD Uniform by Danaleja2005

/obj/item/clothing/under/rank/research_director
	icon_state = "rd"
	item_state = "rd"
	item_color = "rd"
	hispania_icon = TRUE
	icon = 'modularHispania/icons/mob/uniform.dmi'
	sprite_sheets = list(
		"Vox" = 'modularHispania/icons/mob/species/vox/uniform.dmi',
		"Grey" = 'modularHispania/icons/mob/species/grey/uniform.dmi'
		)

/obj/item/clothing/under/rank/research_director/formal
	name = "research director's black formal uniform"
	desc = "A formal uniform with a tie and a badge, it says Research Director"
	icon_state = "rd_black"
	item_color = "rd_black"
	species_restricted = list("exclude", "Grey", "Vox")


/obj/item/clothing/under/rank/research_director/formal/purple
	name = "research director's purple formal uniform"
	icon_state = "rd_purple"
	item_color = "rd_purple"

