class_name InteractionComponent extends Component


@export var interaction_area: Area2D


var interactable_entities: Array[Entity]





func initialize(_entity: Entity) -> void:

	super(_entity)

	var movement_component = entity.get_component(MovementComponent)

	movement_component.face_dir_changed.connect(_on_face_dir_changed)

	print("connect")

	interaction_area.body_entered.connect(_on_body_entered_interaction_area)

	interaction_area.body_exited.connect(_on_body_exited_interaction_area)





func try_interaction() -> void:

	var nearest_interactable = get_nearest_interactable()

	if not nearest_interactable:

		return

	var interactable_component = get_interactable_component(nearest_interactable)

	if not interactable_component.can_interact():

		return

	interactable_component.start_interaction()




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
		




func _on_face_dir_changed(dir: Vector2) -> void:

	interaction_area.rotation = dir.angle()



func _on_body_entered_interaction_area(body: PhysicsBody2D) -> void:

	print(body)

	if body is Entity and body.is_interactable():

		interactable_entities.append(body)



func _on_body_exited_interaction_area(body: PhysicsBody2D) -> void:

	if interactable_entities.has(body):

		interactable_entities.erase(body)





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("interact"):

		try_interaction()