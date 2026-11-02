extends Node



var input_config: InputConfig

var input_config_registry: Dictionary[Game.GameState, InputConfig]




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	var dir = "res://resources/config/input/"

	for dir_name in ResourceLoader.list_directory(dir):

		if dir_name.ends_with("input_config.tres"):

			var _input_config = load(dir + dir_name) as InputConfig

			input_config_registry[_input_config.game_state] = _input_config

	Game.game_state_changed.connect(_on_game_state_changed)




func is_action_allowed(action: StringName) -> bool:

	if not input_config or not input_config.allowed_actions.has(action):

		return false

	return true

			


func _on_game_state_changed(game_state: Game.GameState) -> void:

	if input_config_registry.has(game_state):

		input_config = input_config_registry[game_state]




func _input(event: InputEvent) -> void:

	if event is InputEventMouseMotion or event is InputEventMouseButton:

		return

	for action in input_config.allowed_actions:

		var action_events = InputMap.action_get_events(action)

		for _event in action_events:

			if _event.physical_keycode == event.physical_keycode:

				return

	get_viewport().set_input_as_handled()

