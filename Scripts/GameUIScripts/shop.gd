extends Control

@onready var btn_buy_noraml: Button = $MarginContainer/FlowContainer/BtnNormalSkinBuy
@onready var btn_buy_purple: Button = $MarginContainer/FlowContainer/BtnPurpleSkinBuy
@onready var btn_buy_blastoin: Button = $MarginContainer/FlowContainer/BtnBlastoinSkinBuy


#When scene loads, set the actual equipped skin
func _ready() -> void:
	if GlobalSave.game_data["skin_equipped"] == "Normal":
		btn_buy_noraml.text = "Equipped"
		btn_buy_purple.text = "Equip"
		btn_buy_blastoin.text = "Equip"
		
	elif GlobalSave.game_data["skin_equipped"] == "Purple":
		btn_buy_purple.text = "Equipped"
		btn_buy_noraml.text = "Equip"
		btn_buy_blastoin.text = "Equip"
		
	elif GlobalSave.game_data["skin_equipped"] == "Blastoin":
		btn_buy_noraml.text = "Equip"
		btn_buy_purple.text = "Equip"
		btn_buy_blastoin.text = "Equipped"

#Puts in the button if it Shows Equip, Equiped or Buy
func _process(_delta: float) -> void:
	pass

#Equips the Normal skin if you press the button
func _on_btn_normal_skin_buy_button_down() -> void:
	if btn_buy_noraml.text == "Equip":
		btn_buy_purple.text = "Equip"
		btn_buy_blastoin.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "Noraml"
		btn_buy_noraml.text = "Equipped"
	GlobalSave.save_game()

#Equips the Purple skin if you press the button
func _on_btn_purple_skin_buy_button_down() -> void:
	if btn_buy_purple.text == "Equip":
		btn_buy_noraml.text = "Equip"
		btn_buy_blastoin.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "Purple"
		btn_buy_purple.text = "Equipped"
		GlobalSave.save_game()

func _on_btn_blastoin_skin_buy_button_down() -> void:
	if btn_buy_blastoin.text == "Equip":
		btn_buy_noraml.text = "Equip"
		btn_buy_purple.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "Blastoin"
		btn_buy_blastoin.text = "Equipped"
		GlobalSave.save_game()

func _on_atrás_btn_button_down() -> void:
	GlobalSave.save_game()
	$"../StartMenu".visible = true
	visible = false
