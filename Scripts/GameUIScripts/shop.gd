extends Control

@onready var btn_buy_noraml: Button = $MarginContainer/FlowContainer/BtnNormalSkinBuy
@onready var btn_buy_purple: Button = $MarginContainer/FlowContainer/BtnPurpleSkinBuy
@onready var btn_buy_blastoin: Button = $MarginContainer/FlowContainer/BtnBlastoinSkinBuy
@onready var btn_buy_horizonAtlas: Button = $MarginContainer/FlowContainer/BtnHorizonAtlasSkinBuy

var ShopButtons:Array

#When scene loads, set the actual equipped skin
func _ready() -> void:
	
	#Crea una lista con todos lso botones
	ShopButtons = [$MarginContainer/FlowContainer/BtnNormalSkinBuy, $MarginContainer/FlowContainer/BtnPurpleSkinBuy, $MarginContainer/FlowContainer/BtnBlastoinSkinBuy, $MarginContainer/FlowContainer/BtnHorizonAtlasSkinBuy]
	
	if GlobalSave.game_data["skin_equipped"] == "Normal":
		for button in ShopButtons:
			button.text = "Equip"
		btn_buy_noraml.text = "Equipped"
		
	elif GlobalSave.game_data["skin_equipped"] == "Purple":
		for button in ShopButtons:
			button.text = "Equip"
		
		btn_buy_purple.text = "Equipped"
		
	elif GlobalSave.game_data["skin_equipped"] == "Blastoin":
		for button in ShopButtons:
			button.text = "Equip"
			
		btn_buy_blastoin.text = "Equipped"
		
	elif GlobalSave.game_data["skin_equipped"] == "HorizonAtlas":
		for button in ShopButtons:
			button.text = "Equip"
			
		btn_buy_horizonAtlas.text = "Equipped"

#Puts in the button if it Shows Equip, Equiped or Buy
func _process(_delta: float) -> void:
	pass

#Equips the Normal skin if you press the button
func _on_btn_normal_skin_buy_button_down() -> void:
	if btn_buy_noraml.text == "Equip":
		for button in ShopButtons:
			button.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "Noraml"
		btn_buy_noraml.text = "Equipped"
	GlobalSave.save_game()

#Equips the Purple skin if you press the button
func _on_btn_purple_skin_buy_button_down() -> void:
	if btn_buy_purple.text == "Equip":
		for button in ShopButtons:
			button.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "Purple"
		btn_buy_purple.text = "Equipped"
		GlobalSave.save_game()

func _on_btn_blastoin_skin_buy_button_down() -> void:
	if btn_buy_blastoin.text == "Equip":
		for button in ShopButtons:
			button.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "Blastoin"
		btn_buy_blastoin.text = "Equipped"
		GlobalSave.save_game()

func _on_btn_purple_skin_buy_4_button_down() -> void:
	if btn_buy_horizonAtlas.text == "Equip":
		for button in ShopButtons:
			button.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "HorizonAtlas"
		btn_buy_horizonAtlas.text = "Equipped"
		GlobalSave.save_game()

func _on_atrás_btn_button_down() -> void:
	GlobalSave.save_game()
	$"../StartMenu".visible = true
	visible = false
