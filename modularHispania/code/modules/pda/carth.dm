/obj/item/cartridge/clown
	name = "Honkworks 5.0"
	desc = "A data cartridge for portable microcomputers. Has a virus sender to make anyones PDA honk on any action."
	icon_state = "cart-clown"
	charges = 5
	programs = list(
		new /datum/data/pda/utility/honk,
		new /datum/data/pda/utility/trombone
	)
	messenger_plugins = list(
		new /datum/data/pda/messenger_plugin/virus/clown
	)
