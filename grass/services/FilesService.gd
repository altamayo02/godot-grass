#extends Node
#
#
#class FilesService:
#	enum FileOpen {
#		ERROR,
#		UNKNOWN
#	}
#
#	func read_file(path: String):
#		var file = File.new()
#		file.open(path, File.READ)
#		var content = file.get_as_text()
#		file.close()
#		return content
#
#	func read_json(path: String, create_if_not_exists: bool):
#		var file = read_file(path)
#		var json = JSON.parse(file)
#		if json.get_error() == OK:
#			return json.get_result()
#		else:
#			printerr(
#				"JSON Parse Error: ",
#				json.get_error_string(),
#				" at line ",
#				json.get_error_line()
#			)
#			return FileOpen.ERROR
#		return FileOpen.UNKNOWN
