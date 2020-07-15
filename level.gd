extends Node2D

# Scene template for every in-game level.

const SUBTILE_NAME_BY_COORD := {
	Vector2(11, 4): "win",
}


func _process(_delta: float):
	var player := $Player as Player

	if player.is_idle():
		var subtile_coord := Utils.subtile_coord_for_position(player.position, $TileMap as TileMap)
		if subtile_coord == Vector2.ZERO:
			# TODO: handle error
			pass

		match SUBTILE_NAME_BY_COORD.get(subtile_coord):
			"win":
				win()


func win() -> void:
	Events.emit_signal("scene_completed", get_name())
