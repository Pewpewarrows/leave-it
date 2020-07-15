extends CanvasLayer

# Scene for the title screen.

# TODO: sometimes the GUI does not show? ideal in the long-run, but right now still want some elements to always be visible (like FPS counter)


func _on_Play_pressed() -> void:
	Events.emit_signal("scene_completed", get_name())


func _on_Quit_pressed() -> void:
	Events.emit_signal("quit_requested")
