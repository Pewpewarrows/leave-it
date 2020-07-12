extends Node

var _pause_counter := 0


# TODO: eventually have a separate PauseStack class, can have multiple simultaneously instantiated
func push_to_pause_stack() -> void:
	_pause_counter += 1
#	player.set_process_input(false)
	get_tree().paused = true
	
	
func pop_from_pause_stack() -> void:
	if _pause_counter == 0:
		# TODO: log warning if production, raise exception if debug
		return
		
	_pause_counter -= 1
	
	if _pause_counter == 0:
#		player.set_process_input(true)
		get_tree().paused = false
