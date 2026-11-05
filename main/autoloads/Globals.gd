extends Node




var flags:= {}





func clear_flags() -> void:

	flags.clear()

	print("cleared flags")




func get_flag(key: String, fallback: Variant = null) -> Variant:

	if flags.has(key):

		return flags[key]

	return fallback




func set_flag(key: String, value: Variant) -> void:

	flags[key] = value
