extends Node2D

signal pointschanged()
signal difficultChange()
signal hpChange()

@onready var dificulty_increaser: Timer = $DificultyIncreaser
@onready var meteor_spawner: Node2D = $"../MeteorSpawner"

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
	print("Points Gained")
	pointschanged.emit(points)


func _on_player_ship_life_changed() -> void:
	live -= 1
	hpChange.emit(live)
