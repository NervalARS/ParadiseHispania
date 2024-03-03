/obj/vehicle/clowncar //codigo satisfactoriamente secuestrado de tg
	name = "clown car"
	desc = "How someone could even fit in there is byond me."
	icon= 'modular_hispania/icons/obj/vehicles/vehicleh.dmi'
	icon_state = "clowncar"
	key_type = /obj/item/bikehorn
	vehicle_move_delay = 0
	var/mutable_appearance/micarrooo
/obj/vehicle/clowncar/Initialize(mapload)
	. = ..()
	micarrooo = mutable_appearance(icon, "clowncar", ABOVE_MOB_LAYER)
	add_overlay(micarrooo)

/obj/vehicle/clowncar/post_buckle_mob(mob/living/M)
	if(has_buckled_mobs())
		ADD_TRAIT(M, TRAIT_NOSLIP, UID())
		M.alpha = 0
	else
		M.alpha = 255
		REMOVE_TRAIT(M, TRAIT_NOSLIP, UID())

/obj/vehicle/clowncar/post_unbuckle_mob(mob/living/M)
		M.alpha = 255
		REMOVE_TRAIT(M, TRAIT_NOSLIP, UID())
		return ..()

/obj/vehicle/clowncar/Bump(atom/bumped)
	. = ..()
	if(isliving(bumped))
		if(ismegafauna(bumped))
			return
		var/mob/living/hittarget_living = bumped
		if(iscarbon(hittarget_living))
			var/mob/living/carbon/carb = hittarget_living
			carb.Stun(4 SECONDS)
			carb.forceMove(src)
			visible_message("<span class='rose'>[src] rams into [hittarget_living] and sucks [hittarget_living.p_them()] up!</span>") //lol aqui habia un tgcuck pornoadicto hablando de erp
			playsound(src, pick('sound/items/bikehorn.ogg'), 75)
			log_game(src, hittarget_living, "sucked up")
		return

	if(iswallturf(bumped) || isstructure(bumped) || !istype(bumped, /obj/machinery/door))
		playsound(src, 'sound/items/bikehorn.ogg', 75)
		var/mob/living/mobuckle = buckled_mobs[1]
		visible_message("<span class='rose'>[src] rams into [bumped] and crashes!</span>")
		mobuckle.Weaken(10 SECONDS)
		mobuckle.Stuttering(10 SECONDS)
		unbuckle_mob(mobuckle)
		for(var/mob/living/M in src)
			M.forceMove(loc)
		log_game(src, bumped, "crashed into", null, "dumping all passengers")
	return

/obj/vehicle/clowncar/Destroy()
	playsound(src, 'sound/misc/sadtrombone.ogg', 75)
	QDEL_NULL(inserted_key)
	return ..()
