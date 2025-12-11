extends CanvasLayer

var controls:int

func _ready() -> void:
	GlobalSave.load_game()
	$StartMenu/TotalPointsLbl.text = "Total Points: " + str(GlobalSave.game_data["total_points"])

#Changes to Level Scene
func _on_play_btn_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn")

#Close the Game
func _on_exit_btn_button_down() -> void:
	GlobalSave.save_game()
	get_tree().quit()


func _on_options_btn_button_down() -> void:
	$StartMenu.visible = false
	$OptionsMenu.visible = true


func _on_atrás_btn_button_down() -> void:
	$StartMenu.visible = true
	$OptionsMenu.visible = false
