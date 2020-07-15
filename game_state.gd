extends Node

# Global game state.

const TITLE := "Leave It!"

var scene_tree_pause := make_pause_stack_for_scene_tree()


func make_pause_stack_for_scene_tree() -> PauseStack:
	var pause_fn := funcref(self, "_pause_scene_tree")
	var resume_fn := funcref(self, "_resume_scene_tree")
	
	return PauseStack.new(pause_fn, resume_fn)


func _pause_scene_tree() -> void:
	# TODO: player input freezing?
#	player.set_process_input(false)
	get_tree().paused = true


func _resume_scene_tree() -> void:
	# TODO: player input freezing?
#	player.set_process_input(true)
	get_tree().paused = false
