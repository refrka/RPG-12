class_name CommandSet extends Resource



@export var commands: Array[Command]

var command_index:= 0


func execute_all(data:= {}) -> void:

	command_index = 0

	execute_command(command_index, data)




func execute_command(index: int, data:= {}) -> void:

	var command = commands[index]

	match command.execute(data):

		Command.Result.PENDING:

			command.command_executed.connect(_on_command_executed.bind(command), CONNECT_ONE_SHOT)

		Command.Result.SUCCESS:

			command_index += 1

			if command_index <= commands.size() - 1:

				execute_command(command_index, command.data)





func _on_command_executed(command: Command) -> void:

	command_index += 1

	if command_index <= commands.size() - 1:

		execute_command(command_index, command.data)