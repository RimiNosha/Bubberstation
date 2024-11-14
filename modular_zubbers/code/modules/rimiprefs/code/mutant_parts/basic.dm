/datum/config_entry/flag/disable_mismatched_parts
	default = FALSE

/datum/preference/toggle/allow_mismatched_parts
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_key = "allow_mismatched_parts_toggle"
	default_value = FALSE

/datum/preference/toggle/allow_mismatched_parts/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return // we dont actually want this to do anything

/datum/preference/toggle/allow_mismatched_parts/is_accessible(datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_mismatched_parts))
		return FALSE
	return ..()

/datum/preference/toggle/allow_mismatched_parts/deserialize(input)
	if(CONFIG_GET(flag/disable_mismatched_parts))
		return FALSE
	return ..()

/datum/preference/toggle/allow_mismatched_hair_color
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_key = "allow_mismatched_hair_color_toggle"
	default_value = TRUE

/datum/preference/toggle/allow_mismatched_hair_color/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return // applied in apply_supplementary_body_changes()

/datum/preference/toggle/allow_mismatched_hair_color/is_accessible(datum/preferences/preferences)
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	if(!ispath(species, /datum/species/jelly)) // only slimes can see this pref
		return FALSE
	return ..()

/datum/preference/mutant_color/mutant_colors
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_key = "mutant_colors_color"
	check_mode = TRICOLOR_NO_CHECK

/datum/preference/mutant_color/mutant_colors/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["mcolor"] = sanitize_hexcolor(value[1])
	target.dna.features["mcolor2"] = sanitize_hexcolor(value[2])
	target.dna.features["mcolor3"] = sanitize_hexcolor(value[3])

/datum/preference/toggle/eye_emissives
	savefile_key = "eye_emissives"
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	relevant_head_flag = HEAD_EYECOLOR

/datum/preference/toggle/eye_emissives/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	value = value && preferences

	var/obj/item/organ/internal/eyes/eyes_organ = target.get_organ_by_type(/obj/item/organ/internal/eyes)
	target.emissive_eyes = value
	if (istype(eyes_organ))
		eyes_organ.is_emissive = value

/datum/preference/toggle/eye_emissives/create_default_value()
	return FALSE

// Body Markings - This isn't used anymore and thus I'm making it not do anything.

/datum/preference/toggle/mutant_toggle/body_markings
	savefile_key = "body_markings_toggle"
	relevant_mutant_bodypart = "body_markings"

/datum/preference/toggle/mutant_toggle/body_markings/is_accessible(datum/preferences/preferences)
	. = ..() // Got to do this because of linters.
	return FALSE

/datum/preference/toggle/mutant_toggle/body_markings/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/mutant/body_markings
	savefile_key = "feature_body_markings"
	relevant_mutant_bodypart = "body_markings"
// 	type_to_check = /datum/preference/toggle/mutant_toggle/body_markings
	should_generate_icons = FALSE

/datum/preference/choiced/mutant/body_markings/is_accessible(datum/preferences/preferences)
	. = ..() // Got to do this because of linters.
	return FALSE

/datum/preference/choiced/mutant/body_markings/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/mutant_color/body_markings
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_key = "body_markings_color"
	relevant_mutant_bodypart = "body_markings"
// 	type_to_check = /datum/preference/toggle/mutant_toggle/body_markings

/datum/preference/mutant_color/body_markings/is_accessible(datum/preferences/preferences)
	. = ..() // Got to do this because of linters.
	return FALSE

/datum/preference/mutant_color/body_markings/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/emissive_toggle/body_markings
	category = PREFERENCE_CATEGORY_BUBBER_APPEARANCE
	savefile_key = "body_markings_emissive"
	relevant_mutant_bodypart = "body_markings"
// 	type_to_check = /datum/preference/toggle/mutant_toggle/body_markings

/datum/preference/emissive_toggle/body_markings/is_accessible(datum/preferences/preferences)
	. = ..() // Got to do this because of linters.
	return FALSE

/datum/preference/emissive_toggle/body_markings/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
