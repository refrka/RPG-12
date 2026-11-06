class_name DelayCommand extends Command



@export var event_trigger: Event

@export var duration: float









func execute(_data:= {}) -> Result:

	if super(_data) == Result.FAILURE:

		return result

	if event_trigger:

		Events.subscribe(event_trigger.get_script(), _on_event_trigger)

	else:

		Game.get_tree().create_timer(duration).timeout.connect(_on_timeout)

	result = Result.PENDING

	return result


	
func _on_event_trigger(event: Event) -> void:

	if event.get_script() == event_trigger.get_script():

		command_executed.emit()



func _on_timeout() -> void:

	command_executed.emit()