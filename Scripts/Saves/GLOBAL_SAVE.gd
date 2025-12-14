extends Node

var save_path = "user://save_game.dat"

var game_data : Dictionary = {
	"total_points" = 0,
	"max_score" = 0,
	"languaje" = "English",
	"skin_equipped" = "Normal"
}

func save_game() -> void:
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_file.store_var(game_data) #Guarda la Variable
	save_file = null #Para Cerrar el archivo

func load_game() -> void:
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		
		game_data = save_file.get_var()
		save_file = null
