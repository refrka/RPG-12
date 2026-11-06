class_name ItemStack extends Resource


signal count_changed(new_count: int, amount: int)

signal item_changed(new_item: Item, old_item: Item)

@export var item: Item

@export var count: int




var parennt_inventory: Inventory

var stacks_index:= -1






func set_count(_count: int) -> void:

	var amount = count - _count

	count = _count

	count_changed.emit(count, amount)



func set_item(_item: Item) -> void:

	item = _item

	item_changed.emit(item)



func clear() -> void:

	set_count(0)

	set_item(null)



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

	var new_count = min(item.max_stack, count + amount)

	set_count(new_count)



func remove_amount(amount: int) -> void:

	var new_count = max(0, count - amount)

	set_count(new_count)




func is_empty() -> bool:

	return not item or count <= 0





static func new_stack(_item: Item, _count: int) -> ItemStack:

	var stack:= ItemStack.new()

	if _item is Weapon:

		stack = EquipmentItemStack.new()

	stack.item = _item

	stack.count = _count

	return stack