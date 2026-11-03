class_name Location extends Node2D


@export var character_root: Node2D

@export var prop_root: Node2D

@export var ground_map_layer: TileMapLayer

@export var scene_map_layer: TileMapLayer




func _ready() -> void:

	scene_map_layer.child_entered_tree.connect(_on_child_entered_scene_map_layer)




func open() -> void:

	for entity in character_root.get_children():

		entity.initialize()

		entity.activate()

	for entity in prop_root.get_children():

		entity.initialize()

		entity.activate()















func _on_child_entered_scene_map_layer(child: Node) -> void:

	if child is Prop:

		child.reparent.call_deferred(prop_root)

	elif child is Character:

		child.reparent.call_deferred(character_root)
