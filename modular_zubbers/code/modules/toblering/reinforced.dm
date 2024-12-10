/turf/closed/wall/r_wall
	icon_state = "reinforced_wall-0" // The TG icon is used until initialize, this is to make sure the wall displays properly in strongdmm
	base_icon_state = "wall"

/turf/closed/wall/r_wall/get_cache_key(plating_color, stripe_color, neighbor_stripe)
	return "[icon]:[smoothing_junction]:[plating_color]:[stripe_icon]:[stripe_color]:[neighbor_stripe]:[shiny_wall]:[d_state]"

/turf/closed/wall/r_wall/update_changed_overlays()
	var/list/new_overlays = ..()
	if(d_state)
		var/image/decon_overlay = image('modular_zubbers/icons/turf/walls/decon_states.dmi', "[d_state]")
		decon_overlay.appearance_flags = RESET_COLOR
		new_overlays += decon_overlay

	return new_overlays

/turf/closed/wall/r_wall/syndicate
	icon_state = "plastitanium_wall-0"
	smoothing_flags = SMOOTH_BITMASK // We don't believe in diagonals here.
