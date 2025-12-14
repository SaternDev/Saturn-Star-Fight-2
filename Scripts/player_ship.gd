class_name PlayerShip
extends CharacterBody2D

signal lifeChanged()

const BULLET = preload("uid://dgw0rxrd8kcyq")

@onready var bullet_spawn: Node2D = $BulletSpawn
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shoot_audio: AudioStreamPlayer = $ShootAudio
@onready var game_controller: Node2D = $"../GameController"

@export var speed = 220
var lives = 3
var exploting = false
var difficulty:int
var shootCooldown = 0.3

func _ready() -> void:
	if GlobalSave.game_data["skin_equipped"] == "Normal":
		$AnimatedSprite2D.play("default")
	elif  GlobalSave.game_data["skin_equipped"] == "Purple":
		$AnimatedSprite2D.play("defaultPurple")

func _process(_delta: float) -> void:
	#Gets Difficulty values
	difficulty = game_controller.difficult
	
	if animated_sprite_2d.animation == "Explosion":
		if not animated_sprite_2d.is_playing():
			lifeChanged.emit(true)
	else:
		if Input.is_action_just_pressed("Shoot"):
			shoot()

func _physics_process(_delta: float) -> void:
	var Direction = Input.get_axis("Izquierda","Derecha")
	
	#Changes in playeer speed based in Difficulty
	if difficulty > 4:
		speed = 230
		shootCooldown = 0.2
	elif difficulty > 9:
		speed = 240
		shootCooldown = 0.1
	elif difficulty > 15:
		speed = 260
		shootCooldown = 0.05
	
	#Si no está explotando se mueve
	if not exploting:
			velocity.x = Direction * speed
	
	#Si está explotando deja de moverse
	if exploting:
		velocity.x = 0
		
	move_and_slide()

func shoot():
	if shoot_cooldown.is_stopped():
		shoot_cooldown.start(shootCooldown)
		
		if BULLET == null:
			return
			
		var bulletInstantiate = BULLET.instantiate()
		bulletInstantiate.position = bullet_spawn.global_position
		get_tree().current_scene.add_child(bulletInstantiate)
		
		#Playing Shoot Audio
		shoot_audio.play()

func playerHit():
	lives -= 1
	if lives == 0:
		exploting = true
		animated_sprite_2d.play("Explosion")
	lifeChanged.emit(false)
