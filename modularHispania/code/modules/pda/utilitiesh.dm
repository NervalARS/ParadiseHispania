/datum/data/pda/utility/trombone
	name = "Sad Trombone"
	icon = "frown"
	category = "Clown"

	var/last_trombonasongo //Also no TROMBON EPICO spamming that's LE BAD FOR SOME REASON OR SOMETHING

/datum/data/pda/utility/trombone/start()
	if(!(last_trombonasongo && world.time < last_trombonasongo + 20))
		playsound(pda.loc, 'sound/misc/sadtrombone.ogg', 50, 1)
		last_trombonasongo = world.time
