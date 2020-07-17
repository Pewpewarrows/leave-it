extends Node2D

# Scene template for every in-game level.

const SUBTILE_NAME_BY_COORD := {
	Vector2(11, 4): "win",
}


func _process(_delta: float):
	var player := $Player as Player

	# TODO: should be checking if player is snapped to tile (or emit some sort of even once a player fully passes "into" a tile) instead, but beware of physics processing so fast that the player teleports through at high movespeeds
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
