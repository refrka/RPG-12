class_name PlayerCombatComponent extends CombatComponent







func _unhandled_input(event: InputEvent) -> void:

	if not active:

		return

	if event.is_action_pressed("attack"):

		try_attack()