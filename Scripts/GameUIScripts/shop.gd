extends Control


#When scene loads, set the actual equipped skin
func _ready() -> void:
	if GlobalSave.game_data["skin_equipped"] == "Normal":
		$MarginContainer/ScrollContainer/GridContainer/BtnNormalSkinBuy.text = "Equipped"
		$MarginContainer/ScrollContainer/GridContainer/BtnPurpleSkinBuy.text = "Equip"
	elif GlobalSave.game_data["skin_equipped"] == "Purple":
		$MarginContainer/ScrollContainer/GridContainer/BtnPurpleSkinBuy.text = "Equipped"
		$MarginContainer/ScrollContainer/GridContainer/BtnNormalSkinBuy.text = "Equip"

#Puts in the button if it Shows Equip, Equiped or Buy
func _process(_delta: float) -> void:
	pass

#Equips the Normal skin if you press the button
func _on_btn_normal_skin_buy_button_down() -> void:
	if not GlobalSave.game_data["skin_equipped"] == "Normal":
		if $MarginContainer/ScrollContainer/GridContainer/BtnPurpleSkinBuy.text == "Equipped":
			$MarginContainer/ScrollContainer/GridContainer/BtnPurpleSkinBuy.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "Noraml"
		$MarginContainer/ScrollContainer/GridContainer/BtnNormalSkinBuy.text = "Equipped"

#Equips the Purple skin if you press the button
func _on_btn_purple_skin_buy_button_down() -> void:
	if $MarginContainer/ScrollContainer/GridContainer/BtnPurpleSkinBuy.text == "Equip" and not GlobalSave.game_data["skin_equipped"] == "Purple":
		if $MarginContainer/ScrollContainer/GridContainer/BtnNormalSkinBuy.text == "Equipped":
			$MarginContainer/ScrollContainer/GridContainer/BtnNormalSkinBuy.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "Purple"
		$MarginContainer/ScrollContainer/GridContainer/BtnPurpleSkinBuy.text = "Equipped"


func _on_atrás_btn_button_down() -> void:
	GlobalSave.save_game()
	$"../StartMenu".visible = true
	visible = false
