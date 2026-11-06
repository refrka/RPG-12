class_name GameCamera extends Camera2D




func _ready() -> void:

	attach_to_player.call_deferred()


func attach_to_player() -> void:

	reparent(Game.player)

	global_position = Game.player.global_position