/obj/machinery/button/attempt_press(mob/user)
	. = ..()
	if(.)
		playsound(user, SFX_CLICK_BUTTON, 100, TRUE)
