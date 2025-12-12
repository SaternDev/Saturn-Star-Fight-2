extends Node2D

signal difficultChange()
signal hpChange()

@onready var dificulty_increaser: Timer = $DificultyIncreaser
@onready var meteor_spawner: Node2D = $"../MeteorSpawner"
const GAME_OVER_MENU = preload("uid://be7ro0xlmjd0h")

@export var points:int
@export var difficult:int
@export var live:int = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Difficult Changer
	if dificulty_increaser.is_stopped() and difficult < 15:
		dificulty_increaser.start(20)
		difficult += 1
		difficultChange.emit(difficult)

func PointsGained():
	points += 1


func _on_player_ship_life_changed(animationStoped) -> void:
	if GlobalSave.game_data["max_score"] < points:
		GlobalSave.game_data["max_score"] = points
	if live < 2 and animationStoped:
		get_tree().current_scene.add_child(GAME_OVER_MENU.instantiate())
		
		$"../game_ui".visible = false
		
		GlobalSave.game_data["total_points"] += points
		GlobalSave.save_game()
		get_tree().paused = true
	else:
		live -= 1
		hpChange.emit(live)
