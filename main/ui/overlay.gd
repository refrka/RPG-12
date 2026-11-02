class_name Overlay extends MarginContainer




@export var pause:= false

var active:= false






func activate() -> void:

	active = true

	show()

	if pause:

		Game.pause()

	process_mode = PROCESS_MODE_INHERIT




func deactivate() -> void:

	active = false

	hide()

	if pause:

		Game.unpause()

	process_mode = PROCESS_MODE_DISABLED