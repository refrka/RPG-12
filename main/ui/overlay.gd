class_name Overlay extends MarginContainer


@warning_ignore("unused_signal")

signal close_requested



@export var pause:= false

var active:= false






func activate() -> void:

	active = true

	show()

	if pause:

		Game.pause()




func deactivate() -> void:

	active = false

	hide()

	if pause:

		Game.unpause()