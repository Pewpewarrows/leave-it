class_name PauseStack
extends Object

# TODO
# Allowing for multiple of these to exist (as opposed to a singleton) is advantageous when a game might need various layers of independent pausing for in-game objects (think: stop time or freeze mechanics).

var _count := 0
var _pause_fn: FuncRef
var _resume_fn: FuncRef


func _init(pause_fn: FuncRef, resume_fn: FuncRef) -> void:
	_pause_fn = pause_fn
	_resume_fn = resume_fn


static func pause_node(node: Node) -> void:
	_freeze_node(node)


static func resume_node(node: Node) -> void:
	_freeze_node(node, false)


static func pause_scene(node: Node) -> void:
	_freeze_scene(node)


static func resume_scene(node: Node) -> void:
	_freeze_scene(node, false)


static func _freeze_node(node: Node, freeze := true) -> void:
	# TODO: preserve original values, return as memento
	node.set_process(!freeze)
	node.set_physics_process(!freeze)
	node.set_process_input(!freeze)
	node.set_process_internal(!freeze)
	node.set_process_unhandled_input(!freeze)
	node.set_process_unhandled_key_input(!freeze)
	# TODO: does not freeze particles


static func _freeze_scene(node: Node, freeze := true, ignoring_children := []) -> void:
	_freeze_node(node, freeze)

	# TODO: type hint as Array[Node] somehow
	for c in node.get_children():
		if String(c.get_path()) in ignoring_children:
			continue

		_freeze_scene(c, freeze)


func push() -> void:
	_count += 1
	_pause_fn.call_func()


func pop() -> void:
	if _count < 1:
		# TODO: log warning if production, raise exception if debug
		return

	_count -= 1

	if _count == 0:
		_resume_fn.call_func()
