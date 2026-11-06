class_name ShowDialogueNodeCommand extends Command


@export var speaker_entity_ref: EntityRef

@export var dialogue_node: DialogueNode




func execute(_data:= {}) -> Result:

	if super(_data) == Result.FAILURE:

		return result

	Dialogue.dialogue_ended.connect(_on_dialogue_ended)

	var entity = Game.get_entity_from_ref(speaker_entity_ref)

	Dialogue.show_dialogue_node(entity, dialogue_node)

	result = Result.PENDING

	return result








func _on_dialogue_ended() -> void:

	result = Result.SUCCESS

	command_executed.emit()