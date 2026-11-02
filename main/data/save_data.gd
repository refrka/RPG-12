class_name SaveData extends Resource



var player_data:= {



}

var game_data:= {

	"last_save_unix": -1,

}




func to_dict() -> Dictionary:

	return {

		"player_data": player_data,

		"game_data": game_data,

	}



static func from_dict(dict: Dictionary) -> SaveData:

	var save_data = SaveData.new()

	save_data.game_data = dict.game_data

	save_data.player_data = dict.player_data

	return save_data