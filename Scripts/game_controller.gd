extends Node2D

signal pointschanged()
signal difficultChange()
signal hpChange()

@onready var dificulty_increaser: Timer = $DificultyIncreaser
@onready var meteor_spawner: Node2D = $"../MeteorSpawner"
const GAME_OVER_MENU = preload("uid://be7ro0xlmjd0h")

@export var points:int
var difficult:int
var live:int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Difficult Changer
	if dificulty_increaser.is_stopped():
		dificulty_increaser.start(30.)
		difficult += 1
		difficultChange.emit(difficult)

func PointsGained():
	points += 1
	pointschanged.emit(points)


func _on_player_ship_life_changed() -> void:
	if live < 2:
		get_tree().current_scene.add_child(GAME_OVER_MENU.instantiate())
		get_tree().paused = true
		print("Game Over")
	else:
		live -= 1
		hpChange.emit(live)
