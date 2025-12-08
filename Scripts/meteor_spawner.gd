extends Node2D

@onready var waiting_spawn: Timer = $WaitingSpawn
const METEOR = preload("uid://dfsl4rlftabix")

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
