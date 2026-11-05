extends Node



var subscriptions:= {}




func subscribe(event_script: Script, callback: Callable) -> void:

	if not subscriptions.has(event_script):

		subscriptions[event_script] = []

	if not subscriptions[event_script].has(callback):

		subscriptions[event_script].append(callback)






func fire(event_script: Script, data:= {}) -> void:

	var event = event_script.new()

	event.fire(data)

	if subscriptions.has(event_script):

		var callbacks = subscriptions[event_script]

		for callback in callbacks:

			callback.call(event)

		


