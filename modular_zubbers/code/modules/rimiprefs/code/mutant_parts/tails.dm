/// Tails

/datum/preference/toggle/mutant_toggle/tail
	savefile_key = "tail_toggle"
	relevant_mutant_bodypart = "tail"

/datum/preference/choiced/mutant/tail
	main_feature_name = "Tails"
	savefile_key = "feature_tail"
	relevant_mutant_bodypart = "tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail
	sprite_direction = NORTH
	greyscale_color = COLOR_DARK_BROWN
	// crop_area = list(5, 5, 28, 28) // We'd *ideally* take part of the sprite, but mammal tails will be... mammal tails. - Rimi

/datum/preference/choiced/mutant/tail/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state, suffix)
	if (icon_exists(sprite_accessory.icon, "m_snout_[original_icon_state]_ADJ[suffix]"))
		return "m_tail_[original_icon_state]_ADJ[suffix]"

	return "m_tail_[original_icon_state]_FRONT[suffix]"

/datum/preference/mutant_color/tail
	savefile_key = "tail_color"
	relevant_mutant_bodypart = "tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail

/datum/preference/emissive_toggle/tail
	savefile_key = "tail_emissive"
	relevant_mutant_bodypart = "tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail
