extends CanvasLayer

@onready var pointsLabel: Label = $GameUI/PointsAndLives/Points
@onready var difficultity: Label = $GameUI/Difficultity/Difficultity
@onready var lives: Label = $GameUI/PointsAndLives/Lives

func _on_game_controller_pointschanged(score) -> void:
	pointsLabel.text = str("Points: ", score)

func _on_game_controller_difficult_change(difficult) -> void:
	difficultity.text = str(difficult)


func _on_game_controller_hp_change(live) -> void:
	lives.text = str("Lives: ", live)
