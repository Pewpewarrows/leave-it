extends Node

# Collection of utility functions.

const INT_MAX := 9223372036854775807
const MS_PER_SECOND := 1000


# Move the game window to the center of the current screen.
static func center_window() -> void:
	var screen_size := OS.get_screen_size()
	var window_size := OS.get_window_size()

	OS.set_window_position((screen_size / 2) - (window_size / 2))


# TODO
static func front_clip_array(array: Array, minimum: int, maximum := INT_MAX) -> void:
	while (array.size() > 0) and ((array[0] < minimum) or (array[0] > maximum)):
		array.pop_front()


# TODO
# Returns a zero vector if the cell doesn't have autotiling.
static func subtile_coord_for_position(position: Vector2, tile_map: TileMap) -> Vector2:
	var cell_coord: Vector2 = tile_map.world_to_map(position)

	return tile_map.get_cell_autotile_coord(cell_coord.x as int, cell_coord.y as int)


# TODO
static func tile_name_for_position(position: Vector2, tile_map: TileMap) -> String:
	var cell_coord: Vector2 = tile_map.world_to_map(position)
	var tile_index: int = tile_map.get_cellv(cell_coord)

	if tile_index == tile_map.INVALID_CELL:
		pass # TODO

	return tile_map.tile_set.tile_get_name(tile_index)
