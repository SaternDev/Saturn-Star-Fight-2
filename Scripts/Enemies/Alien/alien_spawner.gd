extends Node2D

var FirstSpawn = false

# Variables que almacenan la posición del jugador
var position_1
var position_1Y
var position_2

# Coordenada X para spawnear
var spawnXPosition

# Instancia del Alien
var alienInstance

# Alien Instance
const ALIEN = preload("uid://l15kr8ip8lbb")

# Spawn Cooldown
var spawnCooldown:int = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position_1 = $"Position 1".position.x
	position_1Y = $"Position 1".position.y
	position_2 = $"Position 2".position.x
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_spawn_cooldown_timeout() -> void:
	
	if FirstSpawn:
		if get_child_count() > 3:
			print("Already One Alien Alive")
			$SpawnCooldown.start(5)
		else:
			print("No Alien, Spawning One")
			spawmProcess()
	else:
		spawmProcess()
		FirstSpawn = true

# Hace aparecer una nave
func spawmProcess():
	$SpawnCooldown.start(spawnCooldown)
	spawnXPosition = randf_range(position_1, position_2)
	alienInstance = ALIEN.instantiate()
	alienInstance.position = Vector2(spawnXPosition, position_1Y)
	add_child(alienInstance)
