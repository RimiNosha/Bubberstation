/obj/item/radio/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		ui?.user?.playsound_local(get_turf(src), SFX_SMALL_BUTTON, 10)
