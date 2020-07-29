tool
class_name AtomicFile
extends Object

# TODO

# TODO
var _verified_file: VerifiedFile
var _old_verified_file: VerifiedFile
var _new_verified_file: VerifiedFile


func _init(path: String) -> void:
	_verified_file = VerifiedFile.new(path)
	_old_verified_file = VerifiedFile.new("%s.old" % path)
	_new_verified_file = VerifiedFile.new("%s.new" % path)


# TODO
func begin_storage() -> File:
	var file := File.new()

	var error := file.open(_new_verified_file.path, File.WRITE_READ)
	if error != OK:
		pass # TODO: raise hell

	return file


# TODO
func commit_storage(file: File) -> void:
	if file.get_path() != _new_verified_file.path:
		pass # TODO: raise hell

	file.close()
	_new_verified_file.save_checksum()

	# dies here? plain file untouched, it and .new exist, so .new will be loaded
	File.move_file(_verified_file.path, _old_verified_file.path)
	File.move_file(_verified_file.checksum_path, _old_verified_file.checksum_path)
	# dies here? .old and .new exist, so .new will be loaded
	File.move_file(_new_verified_file.path, _verified_file.path)
	File.move_file(_new_verified_file.checksum_path, _verified_file.checksum_path)
	# dies here? plain and .old exist, so plain will be loaded
	File.remove_file(_old_verified_file.path)
	File.remove_file(_old_verified_file.checksum_path)


# TODO
func get_valid_path() -> String:
	# For safekeeping, here's how the algorithm would have to work without checksum files:
	# - if foo.old and foo.new exist, both should be valid, do some checks and load foo.new or be safe and load foo.old
	# - if foo and foo.new exist, load foo
	# - if foo and foo.old exist, foo should be fine, but again do some checks

	if _new_verified_file.is_valid():
		return _new_verified_file.path
	elif _verified_file.is_valid():
		return _verified_file.path
	elif _old_verified_file.is_valid():
		return _old_verified_file.path

	return ""
