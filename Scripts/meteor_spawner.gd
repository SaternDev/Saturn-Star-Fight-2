extends Node2D

@onready var game_controller: Node2D = $"../GameController"
@onready var waiting_spawn: Timer = $WaitingSpawn
const METEOR = preload("uid://dfsl4rlftabix")

var MeteorSpeed:int = 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var meteorInstantiate = METEOR.instantiate()
	
	meteorInstantiate.position.x = randf_range($Position1.position.x, $Position2.position.x)
	if waiting_spawn.is_stopped():
		add_child(meteorInstantiate)
		waiting_spawn.start(randf_range(0.,3.))


func _on_game_controller_difficult_change(difficult) -> void:
	MeteorSpeed += difficult * 3
