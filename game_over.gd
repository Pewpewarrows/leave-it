extends CanvasLayer

# Scene after beating the game.

# TODO: show final game stats somewhere here


func _on_Quit_pressed() -> void:
	Events.emit_signal("quit_requested")
