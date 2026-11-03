class_name InteractionComponent extends Component


@export var interaction_area: Area2D






func initialize(_entity: Entity) -> void:

	super(_entity)

	var movement_component = entity.get_component(MovementComponent)

	movement_component.face_dir_changed.connect(_on_face_dir_changed)





func try_interaction() -> void:

	pass






func _on_face_dir_changed(dir: Vector2) -> void:

	interaction_area.rotation = dir.angle()











func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("interact"):

		pass