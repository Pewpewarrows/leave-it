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
# 15. static methods
# 16. public methods
# 17. private methods

extends Node

# Configure initial game setup.

const FOCUS_TARGET_FPS := Engine.target_fps
const UNFOCUSED_FPS := 30


func _ready() -> void:
	OS.set_window_title(GameState.TITLE)
	OS.center_window()
	Utils.dont_set_graphics_card_on_fire()
	# TODO: setup the global and dock menus (macOS), and taskbar menu (windows)
	# TODO: other "being a good platform-specific citizen" customizations


func _notification(what) -> void:
	match what:
		MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
			get_tree().quit() # default behavior
			# TODO: maybe route this through quit event handled by World as well?
			# TODO: decide what to do on mobile
		MainLoop.NOTIFICATION_WM_FOCUS_OUT:
			if UNFOCUSED_FPS < FOCUS_TARGET_FPS:
				Engine.set_target_fps(UNFOCUSED_FPS)
		MainLoop.NOTIFICATION_WM_FOCUS_IN:
			Engine.set_target_fps(FOCUS_TARGET_FPS)
		MainLoop.NOTIFICATION_CRASH:
			# TODO: custom crash reporter
			pass
		# TODO: macOS behavior of these two
		MainLoop.NOTIFICATION_WM_ABOUT:
			pass
		MainLoop.NOTIFICATION_OS_IME_UPDATE:
			pass
		# TODO: iOS behavior of this one
		MainLoop.NOTIFICATION_OS_MEMORY_WARNING:
			pass
		# TODO: Android behavior of these three
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			pass
		MainLoop.NOTIFICATION_APP_RESUMED:
			pass
		MainLoop.NOTIFICATION_APP_PAUSED:
			pass
