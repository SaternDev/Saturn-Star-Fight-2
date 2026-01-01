extends Control

@onready var btn_buy_noraml: Button = $MarginContainer/FlowContainer/BtnNormalSkinBuy
@onready var btn_buy_purple: Button = $MarginContainer/FlowContainer/BtnPurpleSkinBuy
@onready var btn_buy_blastoin: Button = $MarginContainer/FlowContainer/BtnBlastoinSkinBuy
@onready var btn_buy_horizonAtlas: Button = $MarginContainer/FlowContainer/BtnHorizonAtlasSkinBuy

var blastoinPrice = 3000
var horizonAtlasPrice = 1500
var ShopButtons:Array

#Set the actual equipped skin
#Puts in the button if it Shows Equip, Equiped or Buy
func _process(_delta: float) -> void:
	#Pone los precios a las naves
	if not GlobalSave.game_data["BlastoinBuyed"]:
		btn_buy_blastoin.text = "Buy: " + str(blastoinPrice)
	else:
		btn_buy_blastoin.text = "Equip"
	
	if not GlobalSave.game_data["HorizonAtlasBuyed"]:
		btn_buy_horizonAtlas.text = "Buy: " + str(horizonAtlasPrice)
	else:
		btn_buy_horizonAtlas.text = "Equip"
	
	#Crea una lista con todos lso botones
	ShopButtons = [$MarginContainer/FlowContainer/BtnNormalSkinBuy, $MarginContainer/FlowContainer/BtnPurpleSkinBuy, $MarginContainer/FlowContainer/BtnBlastoinSkinBuy, $MarginContainer/FlowContainer/BtnHorizonAtlasSkinBuy]
	
	if GlobalSave.game_data["skin_equipped"] == "Normal":
		for button in ShopButtons:
			if button.text == "Equipped":
				button.text = "Equip"
		
		btn_buy_noraml.text = "Equipped"
		
	elif GlobalSave.game_data["skin_equipped"] == "Purple":
		for button in ShopButtons:
			if button.text == "Equipped":
				button.text = "Equip"
		
		btn_buy_purple.text = "Equipped"
		
	elif GlobalSave.game_data["skin_equipped"] == "Blastoin":
		for button in ShopButtons:
			if button.text == "Equipped":
				button.text = "Equip"
			
		btn_buy_blastoin.text = "Equipped"
		
	elif GlobalSave.game_data["skin_equipped"] == "HorizonAtlas":
		for button in ShopButtons:
			if button.text == "Equipped":
				button.text = "Equip"
			
		btn_buy_horizonAtlas.text = "Equipped"

#Equips the Normal skin if you press the button
func _on_btn_normal_skin_buy_button_down() -> void:
	if btn_buy_noraml.text == "Equip":
		for button in ShopButtons:
			if button.text == "Equipped":
				button.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "Normal"
		btn_buy_noraml.text = "Equipped"
	GlobalSave.save_game()

#Equips the Purple skin if you press the button
func _on_btn_purple_skin_buy_button_down() -> void:
	if btn_buy_purple.text == "Equip":
		for button in ShopButtons:
			if button.text == "Equipped":
				button.text = "Equip"
		GlobalSave.game_data["skin_equipped"] = "Purple"
		btn_buy_purple.text = "Equipped"
		GlobalSave.save_game()

func _on_btn_blastoin_skin_buy_button_down() -> void:
	if GlobalSave.game_data["BlastoinBuyed"]:
		if btn_buy_blastoin.text == "Equip":
			for button in ShopButtons:
				if button.text == "Equipped":
					button.text = "Equip"
			GlobalSave.game_data["skin_equipped"] = "Blastoin"
			btn_buy_blastoin.text = "Equipped"
			GlobalSave.save_game()
	else:
		if GlobalSave.game_data["total_points"] >= blastoinPrice:
			GlobalSave.game_data["total_points"] -= blastoinPrice
			GlobalSave.game_data["BlastoinBuyed"] = true
			btn_buy_blastoin.text = "Equip"
			GlobalSave.save_game()

func _on_btn_horizon_atlas_skin_buy_button_down() -> void:
	if GlobalSave.game_data["HorizonAtlasBuyed"]:
		if btn_buy_horizonAtlas.text == "Equip":
			for button in ShopButtons:
				if button.text == "Equipped":
						button.text = "Equip"
			GlobalSave.game_data["skin_equipped"] = "HorizonAtlas"
			btn_buy_horizonAtlas.text = "Equipped"
			GlobalSave.save_game()
	else:
		if GlobalSave.game_data["total_points"] >= horizonAtlasPrice:
			GlobalSave.game_data["total_points"] -= horizonAtlasPrice
			GlobalSave.game_data["HorizonAtlasBuyed"] = true
			btn_buy_horizonAtlas.text = "Equip"
		GlobalSave.save_game()

func _on_atrás_btn_button_down() -> void:
	GlobalSave.save_game()
	$"../StartMenu".visible = true
	visible = false
