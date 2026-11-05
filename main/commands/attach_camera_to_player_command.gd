class_name AttachCameraToPlayerCommand extends Command







func execute(_data:= {}) -> Result:

	if super(_data) == Result.FAILURE:

		return result

	Game.camera.reparent(Game.player)

	Game.camera.global_position = Game.player.global_position

	result = Result.SUCCESS

	return result