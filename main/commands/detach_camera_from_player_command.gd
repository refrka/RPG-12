class_name DetachCameraFromPlayerCommand extends Command





func execute(_data:= {}) -> Result:

	if super(_data) == Result.FAILURE:

		return result

	Game.camera.reparent(Game.root)

	Game.camera.global_position = Vector2.ZERO

	result = Result.SUCCESS

	return result