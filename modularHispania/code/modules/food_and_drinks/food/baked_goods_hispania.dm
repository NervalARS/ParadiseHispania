/obj/item/food/snacks/pie/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(ishuman(hit_atom))
		var/mob/living/carbon/human/L = hit_atom
		L.Weaken(2 SECONDS)
		playsound(src.loc, 'sound/effects/meatslap.ogg', 50, 1)
	..()
