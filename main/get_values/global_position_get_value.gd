class_name GlobalPositionGetValue extends GetValue




@export var entity_ref: EntityRef

var target: Node2D



func get_value() -> Variant:

	if entity_ref:

		target = Game.get_entity_from_ref(entity_ref)

	value = target.global_position

	return value