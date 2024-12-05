/obj/item
	pickup_sound = SFX_GENERIC_PICKUP
	drop_sound = SFX_GENERIC_DROP

	///If non-null this sound will be used when this item contains something instead of drop_sound.
	var/full_pickup_sound
	///If non-null this sound will be used when this item contains something instead of drop_sound.
	var/full_drop_sound

/obj/item/proc/should_play_full_sound(mob/user)
	return !!contents?.len
