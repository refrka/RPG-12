extends Node


signal game_state_changed(new_state: GameState)


enum GameState {

	INIT,

	MAIN_MENU,

	GAME_ACTIVE,

	GAME_PAUSED,

}

var player: Player:

	get:

		if not player:

			player = get_tree().get_first_node_in_group("player")

		return player

var camera: GameCamera:

	get:

		if not camera:

			camera = get_tree().get_first_node_in_group("game_camera")

		return camera

var root: Node

var game_state: GameState

var save_data: SaveData

var last_save_dict: Dictionary

var pause_count:= 0



func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	load_save_data()





func save() -> void:

	var dict = save_data.to_dict()

	Data.write_dict_to_file(dict)

	last_save_dict = dict




func start() -> void:

	load_save_data()

	set_game_state(GameState.GAME_ACTIVE)



func exit() -> void:

	set_game_state(GameState.MAIN_MENU)



func quit() -> void:

	get_tree().quit()



func reset() -> void:

	save_data = null

	Globals.clear_flags()

	var new_save_data = SaveData.new()

	Data.write_dict_to_file(new_save_data.to_dict())

	load_save_data()





func pause() -> void:

	pause_count += 1

	if not is_paused():

		get_tree().paused = true

	


func unpause() -> void:

	pause_count = max(0, pause_count - 1)

	if pause_count == 0 and is_paused():

		get_tree().paused = false




func load_save_data() -> void:

	var save_dict = Data.read_dict_from_file()

	if save_dict.is_empty():

		Data.create_new_save_file()

		save_dict = Data.read_dict_from_file()

	save_data = SaveData.from_dict(save_dict)

	last_save_dict = save_dict






func set_game_state(_game_state: GameState) -> void:

	game_state = _game_state

	game_state_changed.emit(game_state)

	



func is_paused() -> bool:

	return get_tree().paused




func get_entity_from_ref(entity_ref: EntityRef) -> Entity:

	var entity: Entity = null

	var location = Scenes.get_scene(Location)

	for _entity in location.character_root.get_children():

		if _entity.entity_id == entity_ref.entity_id:

			entity = _entity

	if entity == null:

		for _entity in location.prop_root.get_children():

			if _entity.entity_id == entity_ref.entity_id:

				entity = _entity

	return entity






func enable_player() -> void:

	player.activate()




func disable_player() -> void:

	player.deactivate()