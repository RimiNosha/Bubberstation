/obj/item/reagent_containers/cup/soda_cans
	drop_sound = 'modular_zubbers/sound/items/handling/tin_drop.ogg'

/obj/item/reagent_containers/cup/soda_cans/open_soda(mob/user)
	. = ..()
	// It's open!
	drop_sound = 'modular_zubbers/sound/items/handling/can_drop.ogg'


/obj/item/reagent_containers/cup/soda_cans/burst_soda(atom/target, hide_message)
	. = ..()
	// It's open!
	drop_sound = 'modular_zubbers/sound/items/handling/can_drop.ogg'
