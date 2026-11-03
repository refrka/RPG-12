class_name Hurtbox extends Area2D


signal hit(hitbox: Hitbox, attack_entry: AttackEntry)


var entity: Entity


func take_hit(hitbox: Hitbox, attack_entry: AttackEntry) -> void:

	hit.emit(hitbox, attack_entry)