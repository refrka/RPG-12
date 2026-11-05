extends Node





const SAVE_PATH = "user://save.json"





func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	var save_dict = read_dict_from_file()

	Game.save_data = SaveData.from_dict(save_dict)





func create_new_save_file() -> void:

	var save_data = SaveData.new()

	var dict = save_data.to_dict()

	write_dict_to_file(dict)




func write_dict_to_file(dict: Dictionary) -> void:

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	file.store_string(JSON.stringify(dict, " "))

	file.close()





func read_dict_from_file() -> Dictionary:

	if not FileAccess.file_exists(SAVE_PATH):

		create_new_save_file()

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	var json = JSON.new()

	json.parse(file.get_as_text())

	file.close()

	return json.data




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("quicksave"):

		Game.save()

		Events.fire(DebugEvent)