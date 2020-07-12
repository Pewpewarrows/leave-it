extends Node2D

const SUBTILE_INDEX_BY_NAME = {
	"win": Vector2(11, 4),
}


func _process(_delta: float):
	# IDLE
	if $Player.position == $Player.target_position:
		var cell_vector: Vector2 = $TileMap.world_to_map($Player.position)
		var subtile_index: Vector2 = $TileMap.get_cell_autotile_coord(cell_vector.x, cell_vector.y)
		
		# TODO: figure out how to match on dict values, use SUBTILE_INDEX_BY_NAME["win"]
		match subtile_index:
			Vector2(11, 4):
				win()
		
#		var tile_index: int = $TileMap.get_cellv(cell_vector)
#		var tile_name: String = $TileMap.tile_set.tile_get_name(tile_index)
#
#		match tile_name:
#			"win":
#				win()


func win() -> void:
	Events.emit_signal("level_completed", "level0")
