/obj/item/modular_computer/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(!.)
		return

	// Just plays a fitting sound for the computer on interact.
	if(hardware_flag == PROGRAM_PDA)
		ui?.user?.playsound_local(get_turf(src), 'modular_zubbers/sound/machines/pda_click.ogg', 50, TRUE)
	else
		playsound(src, SFX_TERMINAL_TYPE, 50, TRUE, ignore_walls = FALSE)

