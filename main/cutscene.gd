class_name Cutscene extends Resource


@export var cutscene_id: StringName


@export var command_set: CommandSet






func run() -> void:

	command_set.execute_all()