class_name FireEventCommand extends Command



@export var event: Event





func execute(_data:= {}) -> Result:

	if super(_data) == Result.FAILURE:

		return result

	if data.has("event"):

		event = data.event

	Events.fire_event(event)

	result = Result.SUCCESS

	return result