class_name RunCutsceneCommand extends Command


@export var cutscene_id: StringName


func execute(_data:= {}) -> Result:

	if super(_data) == Result.FAILURE:

		return result

	if data.has("cutscene_id"):

		cutscene_id = data.cutscene_id

	Scenes.run_cutscene(cutscene_id)

	return Result.SUCCESS