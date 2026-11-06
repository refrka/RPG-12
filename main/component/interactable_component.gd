class_name InteractableComponent extends Component



enum InteractionType {

	INSTANT,

	TOGGLE,

	TOGGLE_OVERLAY,

	HOLD,

}


@export var interaction_type: InteractionType





func can_interact() -> bool:

	return true




func start_interaction() -> void:

	pass



func stop_interaction() -> void:

	pass