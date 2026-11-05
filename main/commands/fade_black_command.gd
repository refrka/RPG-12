class_name FadeBlackCommand extends Command



@export var fade_values:= Vector2(0.0, 1.0)

@export var rate:= 1.0


var node_script: NodeScript



func execute(_data:= {}) -> Result:

	if super(_data) == Result.FAILURE:

		return result

	UI.fg_color_rect.color.a = fade_values.x

	if UI.fg_color_rect.color.a == fade_values.y:

		return Result.SUCCESS

	fade()

	result = Result.PENDING

	return result




func fade() -> void:

	node_script = NodeScript.new_process(update_alpha)

	UI.fg_color_rect.add_child(node_script)





func update_alpha(delta: float) -> void:

	if fade_values.x < fade_values.y:

		if fade_values.y > UI.fg_color_rect.color.a:

			UI.fg_color_rect.color.a += delta * rate

		else:

			command_executed.emit()

	else:

		if fade_values.y < UI.fg_color_rect.color.a:

			UI.fg_color_rect.color.a -= delta * rate

		else:

			command_executed.emit()