class_name Hitbox extends Area2D



var attack_entry: AttackEntry

var hit_list: Array

var entity: Entity



func _ready() -> void:

	area_entered.connect(_on_area_entered)




func clear() -> void:

	hit_list.clear()





func hit(hurtbox: Hurtbox) -> void:

	hit_list.append(hurtbox)

	hurtbox.take_hit(self, attack_entry)





func _on_area_entered(area: Area2D) -> void:

	if not area is Hurtbox or hit_list.has(area) or area.entity == entity:

		return

	hit(area)
