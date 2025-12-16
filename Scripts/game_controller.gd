extends Node2D

signal difficultChange()
signal hpChange()

#Ships to Spawn
const PLAYER_SHIP = preload("uid://r0qel3o0n6l")
const BLASTOIN = preload("uid://dh2fs70sp3hs5")

@onready var player_spawn: Node2D = $"../PlayerSpawn"

@onready var dificulty_increaser: Timer = $DificultyIncreaser
@onready var meteor_spawner: Node2D = $"../MeteorSpawner"
const GAME_OVER_MENU = preload("uid://be7ro0xlmjd0h")

@export var points:int
@export var difficult:int
@export var live:int = 3

var ship:CharacterBody2D

func _ready() -> void:
	if BLASTOIN == null:
		return
	if PLAYER_SHIP == null:
		return
	
	if GlobalSave.game_data["skin_equipped"] == "Noraml":
		var shipinstantiate = PLAYER_SHIP.instantiate()
		shipinstantiate.position = player_spawn.position
		get_tree().current_scene.add_child.call_deferred(shipinstantiate)
	elif GlobalSave.game_data["skin_equipped"] == "Purple":
		var shipinstantiate = PLAYER_SHIP.instantiate()
		shipinstantiate.position = player_spawn.position
		get_tree().current_scene.add_child.call_deferred(shipinstantiate)
	elif GlobalSave.game_data["skin_equipped"] == "Blastoin":
		var shipinstantiate = BLASTOIN.instantiate()
		shipinstantiate.position = player_spawn.position
		get_tree().current_scene.add_child.call_deferred(shipinstantiate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#Difficult Changer
	if dificulty_increaser.is_stopped() and difficult < 15:
		dificulty_increaser.start(15)
		difficult += 1
		difficultChange.emit(difficult)
	
	for player in get_tree().current_scene.get_children():
		if player.is_in_group("Players"):
			ship = player
			playerLifes()
			live = player.lives
			

func PointsGained():
	points += 1

func playerLifes():
	if GlobalSave.game_data["max_score"] < points:
		GlobalSave.game_data["max_score"] = points
	if live < 1 and ship.animationEnded:
		get_tree().current_scene.add_child(GAME_OVER_MENU.instantiate())
		
		$"../game_ui".visible = false
		
		GlobalSave.game_data["total_points"] += points
		GlobalSave.save_game()
		get_tree().paused = true
	else:
		hpChange.emit(live)
