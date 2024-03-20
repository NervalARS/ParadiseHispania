#define EQUIPMENT(n, o, p) n = new /datum/data/mining_equipment(n, o, p)

/obj/item/gun/energy/kinetic_accelerator/premiumka
	name = "Premium kinetic accelerator"
	desc = "A premium kinetic accelerator fitted with an extended barrel and increased pressure tank."
	icon = 'modularHispania/icons/obj/hispa_ka.dmi'
	icon_state = "premiumgun"
	item_state = "kineticgun"
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium)

	empty_state = "premiumgun_empty"

/obj/item/ammo_casing/energy/kinetic/premium
	projectile_type = /obj/item/projectile/kinetic/premium

/obj/item/projectile/kinetic/premium
	icon_state = null
	damage = 50
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	log_override = TRUE

//Rapid KA
/obj/item/gun/energy/kinetic_accelerator/premiumka/rapid
	name = "Rapid kinetic accelerator"
	desc = "A Kinetic Accelerator featuring an overclocked charger and a smaller pressure tank."
	icon_state = "rapidka"
	overheat_time = 8
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/rapid)
	max_mod_capacity = 60

	empty_state = "rapidka_empty"

/obj/item/ammo_casing/energy/kinetic/premium/rapid
	projectile_type = /obj/item/projectile/kinetic/premium/rapid

/obj/item/projectile/kinetic/premium/rapid
	name = "Rapid kinetic force"
	damage = 32
	range = 3

//Heavy KA
/obj/item/gun/energy/kinetic_accelerator/premiumka/heavy
	name = "Heavy kinetic accelerator"
	desc = "A robust Kinetic Accelerator capable of shots strongs blasts of kinetic force in close range."
	icon_state = "heavyka"
	flight_x_offset = 12
	flight_y_offset = 11
	overheat_time = 30
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/heavy)
	max_mod_capacity = 30
	knife_x_offset = 15
	knife_y_offset = 8

	empty_state = "heavyka_empty"

/obj/item/ammo_casing/energy/kinetic/premium/heavy
	projectile_type = /obj/item/projectile/kinetic/premium/heavy


/obj/item/projectile/kinetic/premium/heavy
	name = "Heavy kinetic force"
	damage = 170
	range = 2
	pressure_decrease = 0.05


//Precise KA
/obj/item/gun/energy/kinetic_accelerator/premiumka/precise
	name = "Precise kinetic accelerator"
	desc = "A modified Accelerator. This one has been zeroed in with a choked down barrel to give a longer range"
	icon_state = "preciseka"
	flight_x_offset = 16
	flight_y_offset = 13
	overheat_time = 25
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/precise)
	max_mod_capacity = 80
	knife_x_offset = 21
	knife_y_offset = 13
	zoomable = TRUE
	zoom_amt = 7

	empty_state = "preciseka_empty"

/obj/item/ammo_casing/energy/kinetic/premium/precise
	projectile_type = /obj/item/projectile/kinetic/premium/precise

/obj/item/projectile/kinetic/premium/precise
	name = "Precise kinetic force"
	damage = 45
	range = 10

//Modular KA
/obj/item/gun/energy/kinetic_accelerator/premiumka/modular
	name = "Modular kinetic accelerator"
	desc = "A rather bare-bones kinetic accelerator capable of forming to one's preferences."
	icon_state = "modularka"
	flight_x_offset = 15
	flight_y_offset = 21
	overheat_time = 34
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/modular)
	max_mod_capacity = 240
	knife_x_offset = 14
	knife_y_offset = 14

	empty_state = "modularka_empty"

/obj/item/ammo_casing/energy/kinetic/premium/modular
	projectile_type = /obj/item/projectile/kinetic/premium/modular

/obj/item/projectile/kinetic/premium/modular
	name = "Modular kinetic force"
	damage = 15
	range = 3

//BYOKA
/obj/item/gun/energy/kinetic_accelerator/premiumka/byoka
	name = "Custom kinetic accelerator"
	desc = "You're not sure how it's made, but it is truly a kinetic accelerator fit for a clown. Its handle smells faintly of bananas."
	icon_state = "byoka"
	flight_x_offset = 15
	flight_y_offset = 21
	knife_x_offset = 14
	knife_y_offset = 14
	overheat_time = 27
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/byoka)
	max_mod_capacity = 360

/obj/item/ammo_casing/energy/kinetic/premium/byoka
	projectile_type = /obj/item/projectile/kinetic/premium/byoka

/obj/item/projectile/kinetic/premium/byoka
	name = "Odd kinetic force"
	damage = 0
	range = 1

/obj/machinery/mineral/equipment_vendor/Initialize(mapload)
	. = ..()
	prize_list["Kinetic Accelerator"] = list(
		EQUIPMENT("Kinetic Accelerator", /obj/item/gun/energy/kinetic_accelerator, 750),
		EQUIPMENT("KA Adjustable Tracer Rounds", /obj/item/borg/upgrade/modkit/tracer/adjustable, 150),
		EQUIPMENT("KA AoE Damage", /obj/item/borg/upgrade/modkit/aoe/mobs, 2000),
		EQUIPMENT("KA Cooldown Decrease", /obj/item/borg/upgrade/modkit/cooldown, 1000),
		EQUIPMENT("KA Damage Increase", /obj/item/borg/upgrade/modkit/damage, 1000),
		EQUIPMENT("KA Hyper Chassis", /obj/item/borg/upgrade/modkit/chassis_mod/orange, 300),
		EQUIPMENT("KA Minebot Passthrough", /obj/item/borg/upgrade/modkit/minebot_passthrough, 100),
		EQUIPMENT("KA Range Increase", /obj/item/borg/upgrade/modkit/range, 1000),
		EQUIPMENT("KA Super Chassis", /obj/item/borg/upgrade/modkit/chassis_mod, 250),
		EQUIPMENT("KA White Tracer Rounds", /obj/item/borg/upgrade/modkit/tracer, 100),
		EQUIPMENT("Premium Accelerator", /obj/item/gun/energy/kinetic_accelerator/premiumka, 10000),
		EQUIPMENT("Precise Accelerator", /obj/item/gun/energy/kinetic_accelerator/premiumka/precise, 5000),
		EQUIPMENT("Rapid Accelerator", /obj/item/gun/energy/kinetic_accelerator/premiumka/rapid, 5000),
		EQUIPMENT("Heavy Accelerator", /obj/item/gun/energy/kinetic_accelerator/premiumka/heavy, 5000),
		EQUIPMENT("Modular Accelerator", /obj/item/gun/energy/kinetic_accelerator/premiumka/modular, 8000),
		EQUIPMENT("Build-you-own-KA kit", /obj/item/gun/energy/kinetic_accelerator/premiumka/byoka, 10000),
	)

#undef EQUIPMENT
