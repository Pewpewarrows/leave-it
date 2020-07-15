extends Popup

# Pause screen within the GUI.

# TODO: don't show a quit button on mobile
# TODO: don't allow on title screen


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_menu"):
		if visible:
			_on_Resume_pressed()
		else:
			GameState.scene_tree_pause.push()
			# TODO: use one of the popup_centered method variants?
			popup()


func _on_Resume_pressed() -> void:
	GameState.scene_tree_pause.pop()
	hide()


func _on_Quit_pressed() -> void:
	Events.emit_signal("quit_requested")


func _on_Volume_value_changed(value: float) -> void:
	Events.emit_signal("volume_changed", value)
