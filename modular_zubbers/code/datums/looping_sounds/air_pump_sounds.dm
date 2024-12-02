/datum/looping_sound/air_pump
	start_sound = 'modular_zubbers/sound/machines/airpump/airpumpstart.ogg'
	start_length = 1 SECONDS
	mid_sounds = list(
		'modular_zubbers/sound/machines/airpump/airpumpidle1.ogg' = 1,
		'modular_zubbers/sound/machines/airpump/airpumpidle2.ogg' = 1,
		'modular_zubbers/sound/machines/airpump/airpumpidle3.ogg' = 1,
		'modular_zubbers/sound/machines/airpump/airpumpidle4.ogg' = 1,
		'modular_zubbers/sound/machines/airpump/airpumpidle5.ogg' = 1,
	)
	mid_length = 0.99 SECONDS // I hate it, but it gets rid of most micro-stutters.
	end_sound = 'modular_zubbers/sound/machines/airpump/airpumpshutdown.ogg'
	volume = 25
	falloff_distance = 2
	ignore_walls = FALSE
