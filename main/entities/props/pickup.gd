class_name Pickup extends Area2D



@export var sprite: Sprite2D

@export var anim_player: AnimationPlayer

var stack: ItemStack



func _ready() -> void:

	monitorable = false

	anim_player.animation_finished.connect(_on_animation_finished)




func drop() -> void:

	anim_player.play("drop")




func set_stack(_stack: ItemStack) -> void:

	stack = _stack

	if not stack.is_empty():

		sprite.texture = stack.item.item_texture

		sprite.offset = stack.item.item_texture_offset





func _on_animation_finished(anim_name: StringName) -> void:

	if anim_name == "drop":

		monitorable = true

	