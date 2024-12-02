/obj/machinery/computer
	act_sound = SFX_KEYBOARD_CLICKS

	/// Timestamp for the next possible interact sound.
	var/next_interact_sound

/obj/machinery/computer/interact(mob/user)
	. = ..()
	if(world.time > next_interact_sound && isliving(user))
		next_interact_sound = world.time + (0.5 SECONDS)
		playsound(src, SFX_KEYBOARD, 25, TRUE)
