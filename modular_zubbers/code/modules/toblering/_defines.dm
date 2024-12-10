#define WALL_SHINE_PLATING (1<<0)
#define WALL_SHINE_REINFORCED (1<<1)

#define WALL_STRIPE_ICON 'modular_zubbers/icons/turf/walls/wall_stripe.dmi'
#define WALL_STRIPE_WOOD_ICON 'modular_zubbers/icons/turf/walls/wood_wall_stripe.dmi'
#define WALL_STRIPE_SHINE_ICON 'modular_zubbers/icons/turf/walls/wall_stripe_shine.dmi'

#define WALL_SOLID_ICON 'modular_zubbers/icons/turf/walls/solid_wall.dmi'
#define WALL_REINFORCED_ICON 'modular_zubbers/icons/turf/walls/solid_wall_reinforced.dmi'
#define WALL_METAL_ICON 'modular_zubbers/icons/turf/walls/metal_wall.dmi'
#define WALL_STONE_ICON 'modular_zubbers/icons/turf/walls/stone_wall.dmi'
#define WALL_WOOD_ICON 'modular_zubbers/icons/turf/walls/wood_wall.dmi'
#define WALL_CULT_ICON 'modular_zubbers/icons/turf/walls/cult_wall.dmi'

#define WALL_SHINE_SOLID_ICON 'modular_zubbers/icons/turf/walls/solid_wall_shine.dmi'
#define WALL_SHINE_REINFORCED_ICON 'modular_zubbers/icons/turf/walls/solid_wall_reinforced_shine.dmi'

///from base of atom/set_smoothed_icon_state(): (new_junction)
#define COMSIG_ATOM_SET_SMOOTHED_ICON_STATE "set_smoothed_icon_state"

/// This turf contains something using split visiblity
#define TRAIT_CONTAINS_SPLITVIS "contains_splitvis"

// Defines used to convert dirs to 32,32 pixel offsets
#define DIR_TO_PIXEL_Y(dir) ((dir & NORTH) ? 32 : (dir & SOUTH) ? -32 : 0)
#define DIR_TO_PIXEL_X(dir) ((dir & EAST) ? 32 : (dir & WEST) ? -32 : 0)
