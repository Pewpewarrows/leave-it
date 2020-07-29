tool
class_name VerifiedFile
extends Object

# TODO

const CHECKSUM_PATH_FORMAT := "%s.sha256"

# TODO
var path: String
var checksum_path: String


func _init(file_path: String) -> void:
	path = file_path
	checksum_path = CHECKSUM_PATH_FORMAT % path


# TODO
func get_checksum() -> String:
	var file := File.new()

	return file.get_sha256(path)


# TODO
func save_checksum() -> void:
	var file := File.new()

	var checksum := get_checksum()
	if checksum == "":
		pass # TODO: raise hell

	var error := file.open(checksum_path, File.WRITE)
	if error != OK:
		pass # TODO: raise hell

	file.store_string(checksum)
	file.close()


# TODO
func is_valid() -> bool:
	var file := File.new()

	var checksum := get_checksum()
	if checksum == "":
		pass # TODO: raise hell

	var error := file.open(checksum_path, File.READ)
	if error != OK:
		pass # TODO: raise hell

	var stored_checksum := file.get_as_text()
	file.close()

	return checksum == stored_checksum
