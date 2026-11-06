class_name ParallelCommand extends Command


@export var parallel_commands: Array[Command]


var completed_commands: Array[Command]



func execute(_data:= {}) -> Result:

	if super(_data) == Result.FAILURE:

		return result

	for command in parallel_commands:

		match command.execute(data):

			Result.PENDING:

				command.command_executed.connect(_on_command_executed.bind(command), CONNECT_ONE_SHOT)

			Result.SUCCESS:

				completed_commands.append(command)

				check_results()

	return result




func check_results() -> void:

	if completed_commands.size() == parallel_commands.size():

		result = Result.SUCCESS

		command_executed.emit()





func _on_command_executed(command: Command) -> void:

	completed_commands.append(command)

	check_results()