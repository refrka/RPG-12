class_name PrintLineDebugCommand extends Command



@export_multiline var text: String



func execute(_data:= {}) -> Result:

	if super(_data) == Result.FAILURE:

		return result

	if data.has("text"):

		text = data.text

	print(text)

	return Result.SUCCESS