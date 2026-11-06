class_name Inventory extends Resource



@export var stacks: Array[ItemStack]

var size:= 9




func add_stack(stack: ItemStack) -> bool:

	for _stack in get_stacks_with_item(stack.item):

		_stack.merge(stack)

		if stack.is_empty():

			return true

	if not stack.is_empty() and can_add_new_stack():

		stack.stacks_index = stacks.size()

		stacks.append(stack)

		return true

	return false




func remove_stack(stack: ItemStack) -> void:

	var last = stacks.back()

	if stack == last:

		stacks.pop_back()

	else:

		last.stacks_index = stack.stacks_index

		stacks[last.stacks_index] = last

		stack.stacks_index = -1

		stacks.pop_back()




func get_stacks_with_item(item: Item) -> Array:

	return stacks.filter(func(s): return s.item == item)




func can_add_new_stack() -> bool:

	return stacks.size() < size