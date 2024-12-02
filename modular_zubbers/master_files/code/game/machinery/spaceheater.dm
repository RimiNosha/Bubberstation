/obj/machinery/space_heater
	act_sound = null


/obj/machinery/space_heater/toggle_power(user)
	. = ..()
	playsound(src, SFX_CLICK_BUTTON, 75, TRUE)
