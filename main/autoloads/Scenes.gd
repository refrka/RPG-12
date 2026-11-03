extends Node

signal scene_changed(new_scene: Node)



var scene_registry: Dictionary[Script, Node]

var current_scene: Node







func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	var scene_roots = get_tree().get_nodes_in_group("root")

	for root in scene_roots:

		root.child_entered_tree.connect(_on_child_entered_root)

		for child in root.get_children():

			if child.is_in_group("scene"):

				register_scene(child)




func change_scene(new_scene: Node) -> void:

	if current_scene:

		close_scene(current_scene)

	current_scene = new_scene

	open_scene(new_scene)




func open_scene(scene: Node) -> void:

	set_current_scene(scene)

	if scene.has_method("open"):

		scene.open()

	scene.visible = true



func close_scene(scene: Node) -> void:

	if scene.has_method("close"):

		scene.close()

	scene.visible = false

	current_scene = null




func request_scene(scene_script: Script) -> void:

	var scene = get_scene(scene_script)

	if scene:

		change_scene(scene)



func register_scene(scene: Node) -> void:

	scene_registry[scene.get_script()] = scene



func get_scene(scene_script: Script) -> Node:

	assert(scene_registry.has(scene_script), "Invalid scene script: %s" % scene_script)

	return scene_registry[scene_script]



func set_current_scene(scene: Node) -> void:

	current_scene = scene

	scene_changed.emit(current_scene)

















func _on_child_entered_root(child: Node) -> void:

	if child.is_in_group("scene"):

		register_scene(child)
