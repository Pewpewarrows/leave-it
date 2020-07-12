extends Node2D

var current_scene: Node = null


func _ready() -> void:
	var _rc := Events.connect("level_completed", self, "_on_Events_level_completed")
#	var root: Viewport = get_tree().get_root()
#	current_scene = root.get_child(root.get_child_count() - 1)
#	current_scene = root.get_node("World")
#	current_scene = get_child(get_child_count() - 1)
	goto_scene("res://title.tscn")


func restart_game() -> void:
	var currentScene := get_tree().get_current_scene().get_filename()
	print(currentScene) # TODO: debug only
	var _rc := get_tree().change_scene(currentScene)


func goto_scene(path: String) -> void:
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path: String) -> void:
	# It is now safe to remove the current scene
	if current_scene != null:
		current_scene.free()

	# Load the new scene.
	var s := ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
#	get_tree().get_root().add_child(current_scene)
	add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
#	get_tree().set_current_scene(current_scene)


func _on_Events_level_completed(level_name: String) -> void:
	match level_name:
		"title":
			goto_scene("res://level0.tscn")
		"level0":
			goto_scene("res://game_over.tscn")