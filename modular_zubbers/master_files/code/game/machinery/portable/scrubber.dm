/obj/machinery/portable_atmospherics/scrubber
	/// The passive sounds this scrubber emits.
	var/datum/looping_sound/sound_loop

/obj/machinery/portable_atmospherics/scrubber/Initialize(mapload)
	. = ..()
	sound_loop = new /datum/looping_sound/air_pump(src)

/obj/machinery/portable_atmospherics/scrubber/update_icon_state() // Lazy hack fraud code
	. = ..()
	if(on)
		sound_loop.start()
	else
		sound_loop.stop()

