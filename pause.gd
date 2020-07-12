extends Popup

# TODO: don't show a quit button on mobile


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_menu"):
		if visible:
			_on_Resume_pressed()
		else:
			GameState.push_to_pause_stack()
			# TODO: use one of the popup_centered method variants?
			popup()


func _on_Resume_pressed() -> void:
	GameState.pop_from_pause_stack()
	hide()


func _on_Quit_pressed() -> void:
	get_tree().quit()


func _on_Volume_value_changed(value: float) -> void:
	Events.emit_signal("volume_changed", value)
