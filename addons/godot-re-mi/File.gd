tool
extends File

# TODO

# TODO: cannot get this to work, project code cannot see the move method on File

# TODO: this should probably end up being GDNative in the future to stop from shelling out commands, see:
# https://github.com/godot-rust/godot-rust
# https://github.com/godot-rust/book
# https://github.com/godot-rust/project-utils


# TODO
func move(_src: String, _dest: String) -> void:
	print("moving!")


# TODO
static func move_file(src: String, dest: String) -> int:
	var command: String
	var args := []
	var output := []

	match OS.get_name():
		# TODO: iOS/Android/Browser?
		"Windows":
			command = "move"
			# TODO: file path transformation necessary for separators?
		"X11", "OSX", "LinuxBSD":
			command = "mv"
		_:
			return ERR_UNAVAILABLE

	args += [src, dest]

	var res := OS.execute(command, args, true, output, true)
	if res != OK:
		pass # TODO: raise hell

	return OK


# TODO
static func remove_file(file_path: String) -> int:
	var command: String
	var args := []
	var output := []

	match OS.get_name():
		# TODO: iOS/Android/Browser?
		"Windows":
			command = "del"
			# TODO: file path transformation necessary for separators?
		"X11", "OSX", "LinuxBSD":
			command = "rm"
			args.append("-f")
		_:
			return ERR_UNAVAILABLE

	args.append(file_path)

	var res := OS.execute(command, args, true, output, true)
	if res != OK:
		pass # TODO: raise hell

	return OK
