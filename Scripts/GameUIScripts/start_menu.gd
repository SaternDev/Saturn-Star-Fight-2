extends CanvasLayer

#Changes to Level Scene
func _on_play_btn_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn")

#Close the Game
func _on_exit_btn_button_down() -> void:
	get_tree().quit()
