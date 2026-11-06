class_name CombatComponent extends Component





@export var attack_animation_root: AttackAnimationRoot

@export var weapon: Weapon



var attack_index:= 0

var attack_entry: AttackEntry

var attack_animation_name: StringName

var attack_movement_modifier: Modifier


var cooldown_timer:= 0.0



func initialize(_entity: Entity) -> void:

	super(_entity)

	attack_animation_root.anim_player.animation_finished.connect(_on_animation_finished)

	attack_animation_root.hitbox.entity = entity

	if weapon:

		attack_animation_root.anim_player.add_animation_library(weapon.item_id, weapon.animation_library)
	
	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.face_dir_changed.connect(_on_face_dir_changed)





func can_attack() -> bool:

	if cooldown_timer > 0.0:

		return false

	if is_attacking():

		return false

	return true



func try_attack() -> void:

	if can_attack():

		attack()



func attack() -> void:

	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		attack_movement_modifier = Modifier.new_passive(0.0, Modifier.Operator.OVERRIDE)

		movement_component.value_mod_tracker.add_modifier(attack_movement_modifier)

		movement_component.rotation_enabled = false

	attack_entry = get_attack_entry()

	attack_animation_name = get_animation_name()

	attack_animation_root.anim_player.play(attack_animation_name)
	
	attack_animation_root.hitbox.attack_entry = attack_entry



func end_attack() -> void:

	var movement_component = entity.get_component(MovementComponent)

	if movement_component:

		movement_component.value_mod_tracker.remove_modifier(attack_movement_modifier)

		movement_component.rotation_enabled = true

	cooldown_timer = attack_entry.cooldown_duration

	attack_index = 0

	attack_animation_name = &""

	attack_entry = null

	attack_animation_root.hitbox.clear()



func end_cooldown() -> void:

	cooldown_timer = 0.0








func get_animation_name() -> StringName:

	var library_name = &"unarmed" if not weapon else weapon.item_id

	return &"%s/attack_%s" % [library_name, attack_index]




func get_attack_entry(index:= -1) -> AttackEntry:

	if index == -1:

		index = attack_index

	if weapon and weapon.attack_entries.size() - 1 <= index:

		return weapon.attack_entries[index]

	return null




func is_attacking() -> bool:

	return attack_animation_root.anim_player.is_playing()









func _on_animation_finished(anim_name: StringName) -> void:

	if anim_name == attack_animation_name:

		end_attack()




func _on_face_dir_changed(dir: Vector2) -> void:

	attack_animation_root.rotation = dir.angle()





func _process(delta: float) -> void:

	if not active:

		return

	if cooldown_timer > 0.0:

		cooldown_timer -= delta

		if cooldown_timer <= 0.0:

			end_cooldown()

	