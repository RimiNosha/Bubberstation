/obj/machinery
	/// The sound that plays on UI interaction.
	var/act_sound = SFX_SMALL_BUTTON
	/// If TRUE, plays the interaction sound to the current mob only.
	var/act_sound_local = FALSE

/obj/machinery/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(!act_sound)
		return ..()

	if(act_sound_local)
		ui?.user?.playsound_local(get_turf(src), act_sound, 50, vary = TRUE)
	else
		playsound(src, act_sound, 50, vary = TRUE, ignore_walls = FALSE)

	return ..()
