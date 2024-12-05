/obj/item/storage/bag
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound = 'sound/items/handling/cloth_pickup.ogg'

/obj/item/storage/bag/tray
	drop_sound = 'modular_zubbers/sound/items/handling/metal_drop.ogg'
	pickup_sound = 'modular_zubbers/sound/items/handling/metal_pickup.ogg'

/obj/item/storage/bag/tray/Initialize(mapload)
	. = ..()
	atom_storage.silent = TRUE // Why the fuck do these make noise?
