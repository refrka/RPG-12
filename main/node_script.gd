class_name NodeScript extends Node




var process_callback: Callable




static func new_process(callback: Callable) -> NodeScript:

	var node_script = NodeScript.new()

	node_script.process_callback = callback

	return node_script




func _process(delta: float) -> void:

	if process_callback:

		process_callback.call(delta)