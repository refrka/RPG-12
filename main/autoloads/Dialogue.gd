extends Node



signal dialogue_started

signal dialogue_ended



var dialogue_overlay: DialogueOverlay:

	get:

		if not dialogue_overlay:

			dialogue_overlay = UI.get_overlay(DialogueOverlay)

		return dialogue_overlay


var current_dialogue_source: Entity

var current_dialogue_node: DialogueNode

var current_dialogue_options: Array[DialogueOption]

var current_text_index:= 0




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	dialogue_overlay.dialogue_closed.connect(_on_dialogue_closed)

	dialogue_overlay.more_text_label.hide()

	dialogue_overlay.end_dialogue_button.hide()




func start_dialogue(source_entity: Entity) -> void:

	UI.add_overlay(dialogue_overlay)

	set_current_dialogue_source(source_entity)

	var greeting = get_greeting()

	set_current_dialogue_node(greeting)

	set_current_text_index(0)

	Inputs.enable_action("continue_dialogue_text")





func end_dialogue() -> void:

	Inputs.disable_action("continue_dialogue_text")

	UI.remove_overlay(dialogue_overlay)

	dialogue_ended.emit()





func show_dialogue_node(source_entity: Entity, dialogue_node: DialogueNode) -> void:

	set_current_dialogue_source(source_entity)

	set_current_dialogue_node(dialogue_node)

	set_current_text_index(0)

	UI.add_overlay(dialogue_overlay)




func set_current_dialogue_source(entity: Entity) -> void:

	current_dialogue_source = entity

	dialogue_overlay.set_speaker_name(entity.display_name)

	dialogue_overlay.set_speaker_texture(entity.speaker_texture)




func set_current_dialogue_node(node: DialogueNode) -> void:

	current_dialogue_node = node




func set_current_text_index(index: int) -> void:

	current_text_index = index

	var text = get_dialogue_text(index)

	if text != "":

		dialogue_overlay.set_dialogue_text(text)

		if index == current_dialogue_node.dialogue_text.text.size() - 1:

			dialogue_overlay.more_text_label.hide()

			dialogue_overlay.end_dialogue_button.show()

		else:

			dialogue_overlay.more_text_label.show()

			dialogue_overlay.end_dialogue_button.hide()




func get_dialogue_text(index: int) -> String:

	if current_dialogue_node and current_dialogue_node.dialogue_text.text.size() - 1 >= index:

		return current_dialogue_node.dialogue_text.text[index]
	
	return ""



func get_greeting() -> DialogueGreeting:

	var valid_greetings = []

	for greeting in current_dialogue_source.dialogue_library.greetings:

		var passed:= true

		for condition in greeting.show_conditions:

			if not condition.evaluate():

				passed = false

		if passed:

			valid_greetings.append(greeting)

	valid_greetings.sort_custom(func(g1, g2): return g1.priority > g2.priority)

	return valid_greetings.front()








func _on_dialogue_closed() -> void:

	end_dialogue()






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("continue_dialogue_text"):

		set_current_text_index(current_text_index + 1)