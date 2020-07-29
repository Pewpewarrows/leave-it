extends Node

# Collection of utility functions.

const INT_MAX := 9223372036854775807
const MS_PER_SECOND := 1000
const MAX_FPS := 420
const CHUNK_SIZE := 1024


# TODO
static func dont_set_graphics_card_on_fire() -> void:
	if OS.vsync_enabled:
		return

	Engine.set_target_fps(MAX_FPS)


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


# TODO
class Compass:
	# points or winds
	enum {NORTH, EAST, SOUTH, WEST}
	# TODO: use these instead
	enum {N, NbE, NNE, NEbN, NE, NEbE, ENE, EbN, E, EbS, ESE, SEbE, SE, SEbS, SSE, SbE, S, SbW, SSW, SWbS, SW, SWbW, WSW, WbS, W, WbN, WNW, NWbW, NW, NWbN, NNW, NbW}
	# roses
	enum {CARDINAL = 4, PRINCIPLE = 8, HALF = 16, QUARTER = 32}

	# TODO
	var _heading: int

	func _init(heading: int) -> void:
		_heading = heading

	# TODO
	func relative() -> String:
		# TODO: match rest of possible headings
		match _heading:
			NORTH:
				return "up"
			EAST:
				return "right"
			SOUTH:
				return "down"
			WEST:
				return "left"

		return "unknown"


# TODO
static func make_compass_for_direction(direction: Vector2, wind := Compass.CARDINAL) -> Compass:
	# TODO: decide whether to normalize in here or outside
#	direction = direction.normalized()

	match wind:
		Compass.CARDINAL:
			if direction.y >= 0.707:
				return Compass.new(Compass.SOUTH)
			elif direction.y <= -0.707:
				return Compass.new(Compass.NORTH)
			elif direction.x <= -0.707:
				return Compass.new(Compass.WEST)
			elif direction.x >= 0.707:
				return Compass.new(Compass.EAST)
		_:
			# TODO: unsupported
			print_debug("unsupported wind %s, returning likely-wrong SOUTH as default" % wind)

	return Compass.new(Compass.SOUTH)


# TODO
static func save_game(state: String) -> void:
	var atomic_file := AtomicFile.new("TODO")
	var storage_file := atomic_file.begin_storage()
	storage_file.store_string(state)
	atomic_file.commit_storage(storage_file)
