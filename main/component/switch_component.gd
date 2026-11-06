class_name SwitchComponent extends InteractableComponent


signal state_changed(state: bool)


@export var switch_state:= false

@export var switch_frames:= Vector2i(0, 1)

@export var one_way: bool

@export var one_way_state: bool



func set_switch_state(state: bool) -> void:

	if state == switch_state:

		return

	switch_state = state

	entity.sprite.frame = switch_frames.x if state == false else switch_frames.y

	state_changed.emit(state)
	



func start_interaction() -> void:

	set_switch_state(not switch_state)