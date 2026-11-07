class_name InteractionComponent extends Component


@export var interaction_area: Area2D


var interactable_entities: Array[Entity]

var in_dialogue:= false



func initialize(_entity: Entity) -> void:

	super(_entity)

	Dialogue.dialogue_started.connect(_on_dialogue_started)

	Dialogue.dialogue_ended.connect(_on_dialogue_ended)

	var movement_component = entity.get_component(MovementComponent)

	movement_component.face_dir_changed.connect(_on_face_dir_changed)

	interaction_area.body_entered.connect(_on_body_entered_interaction_area)

	interaction_area.body_exited.connect(_on_body_exited_interaction_area)





func try_interaction() -> void:

	var nearest_interactable = get_nearest_interactable()

	if not nearest_interactable:

		return

	var interactable_component = get_interactable_component(nearest_interactable)

	if interactable_component:

		if not interactable_component.can_interact():

			return

		interactable_component.start_interaction()

	elif nearest_interactable.dialogue_library:

		start_dialogue(nearest_interactable)




func get_interactable_component(_entity: Entity) -> Component:

	for component in _entity.component_registry.values():

		if component is InteractableComponent:

			return component

	return null



func get_nearest_interactable() -> Entity:

	var nearest_distance:= INF

	var nearest_entity: Entity = null

	for _entity in interactable_entities:

		var distance = entity.global_position.distance_to(_entity.global_position)

		if not nearest_entity or distance < nearest_distance:

			nearest_entity = _entity

			nearest_distance = distance

	return nearest_entity





func start_dialogue(target_interactable: Entity) -> void:

	in_dialogue = true

	Dialogue.start_dialogue(target_interactable)
		




func _on_face_dir_changed(dir: Vector2) -> void:

	interaction_area.rotation = dir.angle()



func _on_body_entered_interaction_area(body: PhysicsBody2D) -> void:

	if body is Entity and body.is_interactable():

		interactable_entities.append(body)



func _on_body_exited_interaction_area(body: PhysicsBody2D) -> void:

	if interactable_entities.has(body):

		interactable_entities.erase(body)




func _on_dialogue_started() -> void:

	in_dialogue = true



func _on_dialogue_ended() -> void:

	in_dialogue = false




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("interact"):

		if not in_dialogue:

			try_interaction()

		else:

			UI.remove_overlay_from_stack(DialogueOverlay)