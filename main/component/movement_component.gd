class_name MovementComponent extends Component



signal face_dir_changed(dir: Vector2)



var velocity: Vector2

var face_dir: Vector2


var movement_enabled:= true

var rotation_enabled:= true



var value_mod_tracker:= ValueModTracker.new()








func set_face_dir(dir: Vector2) -> void:

	if dir != face_dir and dir != Vector2.ZERO:

		face_dir = dir

		face_dir_changed.emit(dir)




func get_move_dir() -> Vector2:

	return Vector2.ZERO


func get_move_speed() -> float:

	return (50.0 + get_speed_modifier()) * get_speed_multiplier()


func get_speed_modifier() -> float:

	return value_mod_tracker.get_float_add()


func get_speed_multiplier() -> float:

	return value_mod_tracker.get_float_multiply()


func get_velocity_modifier() -> Vector2:

	return value_mod_tracker.get_vector()


func get_velocity() -> Vector2:

	return (get_move_dir() * get_move_speed()) + get_velocity_modifier()









func _physics_process(delta: float) -> void:

	if not active:

		return

	velocity = get_velocity()

	if movement_enabled:

		entity.velocity = velocity

		entity.move_and_slide()

	if rotation_enabled:

		set_face_dir(velocity.normalized())

	value_mod_tracker.tick(delta)