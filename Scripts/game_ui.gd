extends CanvasLayer

@onready var points_label: Label = $GameUI/Points/PointsLabel
@onready var difficultity: Label = $GameUI/Difficultity/Difficultity
@onready var health_img: TextureRect = $GameUI/Lives/HealthImg

#Health bar textures
const HEAL_BAR_SHIP_2 = preload("uid://dtd73qqtvw77m")
const HEAL_BAR_SHIP_3 = preload("uid://dh328kf4nfkg1")
const HEAL_BAR_SHIP_4 = preload("uid://qvpcil8hm5cl")


func _on_game_controller_pointschanged(score) -> void:
	points_label.text = str("Points: ", score)

func _on_game_controller_difficult_change(difficult) -> void:
	difficultity.text = str(difficult)


func _on_game_controller_hp_change(live) -> void:
	if  live == 2:
		health_img.texture = HEAL_BAR_SHIP_2
	elif live == 1:
		health_img.texture = HEAL_BAR_SHIP_3
	else:
		health_img.texture = HEAL_BAR_SHIP_4
