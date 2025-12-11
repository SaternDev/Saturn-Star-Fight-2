extends CanvasLayer

@onready var play_again_btn: Button = $GameOverUI/VBoxContainer/PlayAgainBtn

func _on_play_again_btn_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn")

func _on_start_menu_btn_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
