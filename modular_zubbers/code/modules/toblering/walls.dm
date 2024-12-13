/// Typecache of all objects that we seek out to apply a neighbor stripe overlay
GLOBAL_VAR_INIT(neighbor_typecache, typecacheof(list(
	/obj/machinery/door/airlock,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/shuttle,
	/obj/machinery/door/poddoor,
	/obj/structure/window/reinforced/plasma/fulltile,
	/obj/structure/window/plasma/fulltile,
)))
GLOBAL_LIST_EMPTY(wall_overlays_cache)

/turf/closed/wall
	canSmoothWith = SMOOTH_GROUP_WALLS + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_SHUTTERS

	//These are set by the material, do not touch!!!
	var/material_color
	var/shiny_wall

	var/icon/shiny_wall_icon

	var/stripe_icon
	var/icon/shiny_stripe_icon
	/// Material Set Name
	var/matset_name
	//Ok you can touch vars again :)

	/// Paint color of which the wall has been painted with.
	var/wall_paint
	/// Paint color of which the stripe has been painted with. Will not overlay a stripe if no paint is applied
	var/stripe_paint

	/// If TRUE, this wall will not try to use any of the fancy toblerone wall systems. Used for some things that don't have proper mats (meat/pizza walls, for example)
	var/custom_wall

	/// Appearance cache key. This is very touchy.
	VAR_PRIVATE/cache_key

	var/static/list/bad_walls = list()
	var/static/list/custom_walls = list()
	var/static/list/material_cache = list()

/// Most of this code is pasted within /obj/structure/falsewall. Be mindful of this
/turf/closed/wall/update_overlays()
	if(custom_wall)
		return ..()

	var/plating_color = wall_paint || material_color
	var/stripe_color = stripe_paint || wall_paint || material_color

	var/neighbor_stripe = NONE
	for (var/cardinal = NORTH; cardinal <= WEST; cardinal *= 2) //No list copy please good sir
		var/turf/step_turf = get_step(src, cardinal)
		for(var/atom/movable/movable_thing as anything in step_turf)
			if(GLOB.neighbor_typecache[movable_thing.type])
				neighbor_stripe ^= cardinal
				break

	var/old_cache_key = cache_key
	cache_key = get_cache_key(plating_color, stripe_color, neighbor_stripe)
	if(!(old_cache_key == cache_key))

		var/potential_overlays = GLOB.wall_overlays_cache[cache_key]
		if(potential_overlays)
			overlays = potential_overlays
			color = plating_color
		else
			color = plating_color
			//Updating the unmanaged wall overlays (unmanaged for optimisations)
			overlays.len = 0
			var/list/new_overlays = update_changed_overlays(plating_color, stripe_color, neighbor_stripe)
			overlays = new_overlays
			GLOB.wall_overlays_cache[cache_key] = new_overlays

	if(dent_decals)
		add_overlay(dent_decals)

	//And letting anything else that may want to render on the wall to work (ie components)
	return ..()

/turf/closed/wall/examine(mob/user)
	. += ..()
	if(wall_paint)
		. += span_notice("It's coated with a <font color=[wall_paint]>layer of paint</font>.")
	if(stripe_paint)
		. += span_notice("It has a <font color=[stripe_paint]>painted stripe</font> around its base.")

/// Most of this code is pasted within /obj/structure/falsewall. Be mindful of this
/turf/closed/wall/proc/paint_wall(new_paint)
	wall_paint = new_paint
	update_appearance()

/// Most of this code is pasted within /obj/structure/falsewall. Be mindful of this
/turf/closed/wall/proc/paint_stripe(new_paint)
	stripe_paint = new_paint
	update_appearance()

/// Most of this code is pasted within /obj/structure/falsewall. Be mindful of this
/turf/closed/wall/proc/set_wall_information(plating_mat, reinf_mat, new_paint, new_stripe_paint)
	wall_paint = new_paint
	stripe_paint = new_stripe_paint
	set_materials(plating_mat)

/// Most of this code is pasted within /obj/structure/falsewall. Be mindful of this
/turf/closed/wall/proc/set_materials(obj/item/stack/plating_mat)
	if(!plating_mat)
		CRASH("Something tried to set wall plating to null!")

	var/datum/material/plating_mat_ref
	if(plating_mat && initial(plating_mat.material_type))
		plating_mat_ref = GET_MATERIAL_REF(initial(plating_mat.material_type))
	else
		plating_mat_ref = material_cache[plating_mat]
		if(!plating_mat_ref && plating_mat_ref != FALSE)
			var/obj/thing = new plating_mat // Fuck I hate this fucking why byond
			if(thing.custom_materials && thing.custom_materials[1]) // Hail mary for weird walls that don't use normal mats.
				plating_mat_ref = GET_MATERIAL_REF(thing.custom_materials[1])
				material_cache[plating_mat] = plating_mat_ref
			else
				custom_wall = TRUE
				custom_walls |= type
				return
		else
			custom_wall = TRUE
			custom_walls |= type
			return

	if(!plating_mat_ref)
		stack_trace("[type] has no valid material!")
		bad_walls |= type
		return

	base_icon_state = "wall" // I CBA going through all the subtypes.
	canSmoothWith = SMOOTH_GROUP_WALLS + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_SHUTTERS // Ditto

	icon = plating_mat_ref.wall_icon
	stripe_icon = plating_mat_ref.wall_stripe_icon

	shiny_wall = plating_mat_ref.wall_shine
	if(shiny_wall)
		shiny_wall_icon = plating_mat_ref.wall_shine_icon
		shiny_stripe_icon = plating_mat_ref.wall_stripe_shine_icon

	material_color = plating_mat_ref.wall_color || plating_mat_ref.color || plating_mat_ref.greyscale_color

	name = "[plating_mat_ref.name] [plating_mat_ref.wall_name]"
	desc = "It seems to be a section of hull plated with [plating_mat_ref.name]."

	matset_name = name

	update_appearance(UPDATE_ICON)

/turf/closed/wall/proc/get_cache_key(plating_color, stripe_color, neighbor_stripe)
	return "[icon]:[smoothing_junction]:[plating_color]:[stripe_icon]:[stripe_color]:[neighbor_stripe]:[shiny_wall]"

/turf/closed/wall/proc/update_changed_overlays(plating_color, stripe_color, neighbor_stripe)
	var/list/new_overlays = list()
	if(shiny_wall)
		var/image/shine = image(shiny_wall_icon, "shine-[smoothing_junction]")
		shine.appearance_flags = RESET_COLOR
		new_overlays += shine

	var/image/smoothed_stripe = image(stripe_icon, "stripe-[smoothing_junction]")
	smoothed_stripe.appearance_flags = RESET_COLOR
	smoothed_stripe.color = stripe_color
	new_overlays += smoothed_stripe

	if(shiny_wall)
		var/image/stripe_shine = image(shiny_stripe_icon, "shine-[smoothing_junction]")
		stripe_shine.appearance_flags = RESET_COLOR
		new_overlays += stripe_shine

	if(neighbor_stripe)
		var/image/neighb_stripe_overlay = image('modular_zubbers/icons/turf/walls/neighbor_stripe.dmi', "stripe-[neighbor_stripe]")
		neighb_stripe_overlay.appearance_flags = RESET_COLOR
		neighb_stripe_overlay.color = stripe_color
		new_overlays += neighb_stripe_overlay
		if(shiny_wall)
			var/image/shine = image('modular_zubbers/icons/turf/walls/neighbor_stripe_shine.dmi', "shine-[neighbor_stripe]")
			shine.appearance_flags = RESET_COLOR
			new_overlays += shine

	// if(rusted)
	// 	var/image/rust_overlay = image('icons/turf/rust_overlay.dmi', "blobby_rust")
	// 	rust_overlay.appearance_flags = RESET_COLOR
	// 	new_overlays += rust_overlay

	return new_overlays
