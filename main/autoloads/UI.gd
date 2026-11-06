extends Node




var overlay_stack: Array[Overlay]

var overlay_registry: Dictionary[Script, Overlay]


var fg_color_rect: ColorRect




func _ready() -> void:

	process_mode = PROCESS_MODE_ALWAYS

	for overlay in get_tree().get_nodes_in_group("overlay"):

		overlay_registry[overlay.get_script()] = overlay

		overlay.deactivate()

		overlay.close_requested.connect(_on_overlay_close_requested.bind(overlay))

	fg_color_rect = get_tree().get_first_node_in_group("fg_color_rect")





func add_overlay_to_stack(overlay_script: Script) -> void:

	var overlay = get_overlay(overlay_script)
	
	if overlay:

		add_overlay(overlay)



func remove_overlay_from_stack(overlay_script: Script = null) -> void:

	var overlay: Overlay = null

	if overlay_script == null:

		overlay = overlay_stack.back()

	else:

		overlay = get_overlay(overlay_script)

	remove_overlay(overlay)



func get_overlay(overlay_script: Script) -> Overlay:

	if overlay_registry.has(overlay_script):

		return overlay_registry[overlay_script]

	return null



func is_in_stack(overlay_script: Script) -> bool:

	var overlay = get_overlay(overlay_script)

	return overlay_stack.has(overlay)




func add_overlay(overlay: Overlay) -> void:

	overlay_stack.append(overlay)

	overlay.activate()



func remove_overlay(overlay: Overlay) -> void:

	overlay_stack.erase(overlay)

	overlay.deactivate()

	




func _on_overlay_close_requested(overlay: Overlay) -> void:

	remove_overlay(overlay)




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("profile"):

		if not is_in_stack(ProfileOverlay):

			add_overlay_to_stack(ProfileOverlay)

		else:

			remove_overlay_from_stack(ProfileOverlay)

	if event.is_action_pressed("back"):

		if not overlay_stack.is_empty():

			var top_overlay = overlay_stack.back()

			remove_overlay(top_overlay)




		