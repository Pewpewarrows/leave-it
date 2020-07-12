extends CanvasLayer


func _on_Play_pressed() -> void:
	Events.emit_signal("level_completed", "title")


func _on_Quit_pressed() -> void:
	get_tree().quit()
