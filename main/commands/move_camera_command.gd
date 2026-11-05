class_name MoveCameraCommand extends Command


@export var start_position: Vector2

@export var end_position: Vector2

@export var speed:= 0.0



var node_script: NodeScript


func execute(_data:= {}) -> Result:

	if super(_data) == Result.FAILURE:

		return result

	if data.has("start_position"):

		start_position = data.start_position

	if data.has("end_position"):

		end_position = data.end_position

	if data.has("speed"):

		speed = data.speed

	if speed <= 0.0:

		Game.camera.global_position = end_position

		result = Result.SUCCESS

	else:

		move()

		result = Result.PENDING
	
	return result





func move() -> void:

	node_script = NodeScript.new_process(update_position)

	Game.camera.add_child(node_script)



func end_move() -> void:

	node_script.queue_free()

	command_executed.emit()



func update_position(_delta: float) -> void:

	Game.camera.global_position = Game.camera.global_position.move_toward(end_position, speed)

	if Game.camera.global_position == end_position:

		end_move()