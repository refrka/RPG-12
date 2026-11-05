class_name IsFlagCondition extends Condition


@export var key: StringName

@export var value: Variant



func evaluate(_data:= {}) -> bool:

	super(data)

	if data.has("key"):

		key = data.key

	if data.has("value"):

		value = data.value

	print(Globals.flags)

	print(key)

	print(value)

	return Globals.get_flag(key, false) == value