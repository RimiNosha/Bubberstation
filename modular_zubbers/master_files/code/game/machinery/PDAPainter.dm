/obj/machinery/pdapainter/eject_pda(mob/living/user)
	var/pda_stored = stored_pda
	. = ..()
	if(pda_stored && !stored_pda)
		playsound(src, 'sound/machines/terminal/terminal_insert_disc.ogg', 75, TRUE)

/obj/machinery/pdapainter/insert_pda(obj/item/modular_computer/pda/new_pda, mob/living/user)
	. = ..()
	if (.)
		playsound(src, 'sound/machines/terminal/terminal_insert_disc.ogg', 75, TRUE)

/obj/machinery/pdapainter/insert_id_card(obj/item/card/id/new_id_card, mob/living/user)
	. = ..()
	if (.)
		playsound(src, 'modular_zubbers/sound/machines/id_insert.ogg', 75, TRUE)

/obj/machinery/pdapainter/eject_id_card(mob/living/user)
	var/id_stored = stored_id_card
	. = ..()
	if(id_stored && !stored_id_card)
		playsound(src, 'modular_zubbers/sound/machines/id_eject.ogg', 75, TRUE)
