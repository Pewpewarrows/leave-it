# 01. tool
# 02. class_name
# 03. extends
# 04. # docstring
#
# 05. signals
# 06. enums
# 07. constants
# 08. exported variables
# 09. public variables
# 10. private variables
# 11. onready variables
#
# 12. optional built-in virtual _init method
# 13. built-in virtual _ready method
# 14. remaining built-in virtual methods (_enter_tree, _exit_tree, _process, _physics_process, _input, _unhandled_input, _draw, _notification)
# 15. public methods
# 16. private methods

extends Node


func _ready() -> void:
	OS.set_window_title("Leave It!")
	center_window()


func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
			get_tree().quit() # default behavior
			# TODO: decide what to do on mobile


func center_window() -> void:
	# var screen_size := OS.get_screen_size(screen=0)
	# var window_size := OS.get_window_size()

	# OS.set_window_position(screen_size * 0.5 - window_size * 0.5)
	pass
