class_name Command extends Resource

@warning_ignore("unused_signal")

signal command_executed


enum Result {

	PENDING,

	SUCCESS,

	FAILURE,

	CANCELLED,

}



@export var conditions: Array[Condition]


var data: Dictionary

var result: Result






func execute(_data:= {}) -> Result:

	data = _data

	for condition in conditions:

		if not condition.evaluate(data):

			result = Result.FAILURE

			return result

	return Result.SUCCESS




static func run(_data:= {}) -> Result:

	return Result.SUCCESS