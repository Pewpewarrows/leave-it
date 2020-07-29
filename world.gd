extends Node2D

# Active main scene and background audio.

var worldport := WorldPort.new(self)


func _ready() -> void:
	_connect_event("quit_requested")
	_connect_event("scene_completed")
	_connect_event("volume_changed")

	var res := worldport.change_scene("res://title.tscn")
	if res != OK:
		pass # TODO: raise hell


func restart_game() -> void:
	# TODO: collision with class var, and test that it works?
	var currentScene := get_tree().get_current_scene().get_filename()
	print_debug("restarting game with scene %s" % currentScene)
	var _res := get_tree().change_scene(currentScene)
	# TODO: reset GameState?


func _connect_event(event_name) -> void:
	var res := Events.connect(event_name, self, "_on_Events_%s" % event_name)
	if res != OK:
		pass # TODO: raise hell


func _on_Events_quit_requested() -> void:
	# TODO: maybe try to save
	get_tree().quit()


func _on_Events_scene_completed(scene_name: String) -> void:
	var next_scene_name: String

	match scene_name:
		"Title":
			next_scene_name = "res://level0.tscn"
		"Level 0":
			next_scene_name = "res://game_over.tscn"

	var res := worldport.change_scene(next_scene_name)
	if res != OK:
		pass # TODO: raise hell


func _on_Events_volume_changed(volume: float) -> void:
	($"Background Music" as AudioStreamPlayer).set_volume_db(linear2db(volume))
