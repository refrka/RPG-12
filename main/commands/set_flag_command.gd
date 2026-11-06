class_name SetFlagCommand extends Command


@export var key: String

@export var value: Variant





func execute(_data:= {}) -> Result:

	if super(data) == Result.FAILURE:

		return result

	if data.has("key"):

		key = _data.key

	if data.has("value"):

		value = _data.value

	Globals.set_flag(key, value)

	result = Result.SUCCESS

	return result





static func run(_data:= {}) -> Result:

	var command = SetFlagCommand.new()

	return command._execute(_data)