class_name CommandSet extends Resource

signal all_commands_executed

@export var commands: Array[Command]

var command_index:= 0

var active_command: Command


func execute_all(data:= {}) -> void:

	command_index = 0

	execute_command(command_index, data)




func execute_command(index: int, data:= {}) -> void:

	active_command = commands[index]

	match active_command.execute(data):

		Command.Result.PENDING:

			active_command.command_executed.connect(_on_command_executed.bind(active_command), CONNECT_ONE_SHOT)

		Command.Result.SUCCESS:

			command_index += 1

			if command_index <= commands.size() - 1:

				execute_command(command_index, active_command.data)

			else:

				all_commands_executed.emit()




func is_executing() -> bool:

	return active_command != null





func _on_command_executed(command: Command) -> void:

	active_command = null

	command_index += 1

	if command_index <= commands.size() - 1:

		execute_command(command_index, command.data)

	else:

		all_commands_executed.emit()