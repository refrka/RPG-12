class_name Cutscene extends Resource


@export var cutscene_id: StringName


@export var command_set: CommandSet






func run() -> void:

	command_set.all_commands_executed.connect(_on_all_commands_executed)

	Game.disable_player()

	command_set.execute_all()



func end() -> void:

	Scenes.end_cutscene()




func _on_all_commands_executed() -> void:

	end()

