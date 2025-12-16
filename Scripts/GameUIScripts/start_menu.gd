extends CanvasLayer

var controls:int

func _ready() -> void:
	GlobalSave.load_game()
	$StartMenu/TotalPointsLbl.text = TranslationServer.translate("Menu_lbl_TotalPoints") + str(GlobalSave.game_data["total_points"])
	if TranslationServer.get_locale() == "es":
		$OptionsMenu/Options/HBoxContainer/Elecciones/IdiomaOpBtn.select(0)
	elif TranslationServer.get_locale() == "en":
		$OptionsMenu/Options/HBoxContainer/Elecciones/IdiomaOpBtn.select(1)

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
	GlobalSave.save_game()
	$StartMenu.visible = true
	$OptionsMenu.visible = false


func _on_idioma_op_btn_item_selected(index: int) -> void:
	if index == 0:
		TranslationServer.set_locale("es")
	elif index == 1:
		TranslationServer.set_locale("en")
	$StartMenu/TotalPointsLbl.text = TranslationServer.translate("Menu_lbl_TotalPoints") + str(GlobalSave.game_data["total_points"])


func _on_patch_notes_button_down() -> void:
	if $PathcNotes.visible:
		$PathcNotes.visible = false
		$StartMenu/MarginContainer.visible = true
	else:
		$PathcNotes.visible = true
		$StartMenu/MarginContainer.visible = false


func _on_shop_btn_button_down() -> void:
	$Shop.visible = true
	$StartMenu.visible = false
