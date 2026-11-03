class_name Entity extends PhysicsBody2D


@export var entity_id: StringName

@export var inventory:= Inventory.new()

@export var component_root: Node

@export var anim_player: AnimationPlayer


var component_registry: Dictionary[Script, Component]


var active:= false





func initialize() -> void:

	for component in component_root.get_children():

		component_registry[component.get_script()] = component

		component.initialize(self)




func activate() -> void:

	active = true

	component_registry.values().map(func(c): c.activate())



func deactivate() -> void:

	active = false

	component_registry.values().map(func(c): c.deactivate())
















func get_component(component_script: Script) -> Component:

	if component_registry.has(component_script):

		return component_registry[component_script]

	return null



func has_component(component_script: Script) -> bool:

	return component_registry.has(component_script)




func is_interactable() -> bool:

	for component in component_registry.values():

		if component is InteractableComponent:

			return true

	return false



