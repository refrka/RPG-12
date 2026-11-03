class_name ItemStack extends Resource


signal count_changed(new_count: int, amount: int)

@export var item: Item

@export var count: int




var parennt_inventory: Inventory

var stacks_index:= -1






func set_count(_count: int) -> void:

	count = _count




func can_merge(stack: ItemStack) -> bool:

	if item != stack.item:

		return false

	return true



func merge(stack: ItemStack) -> void:

	var remaining = stack.count

	var space = item.max_stack - count

	var to_add = 0

	if space >= remaining:

		to_add = remaining

		remaining = 0

	else:

		to_add = space

		remaining -= to_add

	add_amount(to_add)

	stack.remove_amount(to_add)




func add_amount(amount: int) -> void:

	count = min(item.max_stack, count + amount)

	count_changed.emit(count, amount)



func remove_amount(amount: int) -> void:

	count = max(0, count - amount)

	count_changed.emit(count, -amount)




func is_empty() -> bool:

	return not item or count <= 0





func new_stack(_item: Item, _count: int) -> ItemStack:

	var stack:= ItemStack.new()

	if _item is Weapon:

		stack = EquipmentItemStack.new()

	stack.item = _item

	stack.count = _count

	return stack