class_name Player extends Character







func get_component(component_script: Script) -> Component:

	if component_script == MovementComponent:

		component_script = PlayerMovementComponent

	elif component_script == CombatComponent:

		component_script = PlayerCombatComponent

	return super(component_script)