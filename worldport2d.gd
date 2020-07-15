class_name WorldPort2D
extends Node2D

var current_scene: Node

# TODO
# offers an equivalent of the SceneTree.change_scene() API


# TODO
func change_scene(path: String) -> int:
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	if not File.new().file_exists(path):
		return ERR_CANT_OPEN

	call_deferred("_deferred_change_scene", path)

	return OK


# TODO
func _deferred_change_scene(path: String) -> int:
	# It is now safe to remove the current scene
	if current_scene != null:
		current_scene.free()

	# TODO: maybe move this portion to change_scene above to be able to return more error codes
	var scene := ResourceLoader.load(path) as PackedScene

	if scene == null:
		return ERR_CANT_OPEN

	current_scene = scene.instance()
	add_child(current_scene)

	# TODO: check if instance successful, ERR_CANT_CREATE

	var is_root: bool = (get_tree().get_root() == self)

	if is_root:
		# stay compatible with SceneTree.change_scene()
		get_tree().set_current_scene(current_scene)

	return OK
