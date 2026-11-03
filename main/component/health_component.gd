class_name HealthComponent extends Component


@export var hurtbox: Hurtbox

@export var max_health:= 1

var current_health:= 1




func initialize(_entity: Entity) -> void:

	super(_entity)

	hurtbox.hit.connect(_on_hurtbox_hit)

	hurtbox.entity = entity

	entity.anim_player.animation_finished.connect(_on_anim_finished)





func _on_hurtbox_hit(hitbox: Hitbox, attack_entry: AttackEntry) -> void:

	current_health -= 1

	if current_health <= 0:

		entity.anim_player.play("%s/die" % entity.entity_id)



func _on_anim_finished(anim_name: String) -> void:

	entity.queue_free.call_deferred()