extends Node

func json_as_dict(filepath=""):
	if filepath == "" or null:
		return

	var file = File.new()
	file.open(filepath,File.READ)

	var file_text = file.get_as_text()
	var json_dict = parse_json(file_text)
	
	return json_dict
