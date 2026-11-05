extends Node





func _ready() -> void:

	Game.root = self

	Game.game_state_changed.connect(_on_game_state_changed)

	Game.set_game_state(Game.GameState.MAIN_MENU)





func _on_game_state_changed(game_state: Game.GameState) -> void:

	match game_state:

		Game.GameState.MAIN_MENU:

			Scenes.request_scene(MainMenu)

		Game.GameState.GAME_ACTIVE:

			Scenes.request_scene(Location)





