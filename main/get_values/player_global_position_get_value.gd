class_name PlayerGlobalPositionGetValue extends GlobalPositionGetValue





func get_value() -> Variant:

	target = Game.player

	value = target.global_position

	return value