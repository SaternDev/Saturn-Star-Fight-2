extends CharacterBody2D

const CHRITMAS_BULLET = preload("uid://cwip7fdkelykr")

#Bullets Spawners
@onready var bullet_spawn: Node2D = $BulletSpawn
@onready var bullet_spawn_2: Node2D = $BulletSpawn2
@onready var bullet_spawn_3: Node2D = $BulletSpawn3

@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shoot_audio: AudioStreamPlayer = $ShootAudio
@onready var game_controller: Node2D = $"../GameController"

@export var speed = 220
@export var lives = 3
var animationEnded = false
var exploting = false
var difficulty:int
var shootCooldown = 0.3

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	#Gets Difficulty values
	difficulty = game_controller.difficult
	
	if $AnimationPlayer.active == true:
		if not $AnimationPlayer.is_playing():
			animationEnded = true
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
			if Direction == 0:
				$AnimatedSprite2D.play("default")
			elif Direction > 0:
				$AnimatedSprite2D.play("MovementRight")
			else:
				$AnimatedSprite2D.play("MovementLeft")
	
	#Si está explotando deja de moverse
	if exploting:
		velocity.x = 0
		
	move_and_slide()

func shoot():
	if shoot_cooldown.is_stopped():
		shoot_cooldown.start(shootCooldown)
		
		if CHRITMAS_BULLET == null:
			return
			
		var bulletInstantiate = CHRITMAS_BULLET.instantiate()
		var bulletInstantiate2 = CHRITMAS_BULLET.instantiate()
		var bulletInstantiate3 = CHRITMAS_BULLET.instantiate()
		bulletInstantiate.position = bullet_spawn.global_position
		bulletInstantiate2.position = bullet_spawn_2.global_position
		bulletInstantiate3.position = bullet_spawn_3.global_position
		get_tree().current_scene.add_child(bulletInstantiate)
		get_tree().current_scene.add_child(bulletInstantiate2)
		get_tree().current_scene.add_child(bulletInstantiate3)
		
		#Playing Shoot Audio
		shoot_audio.play()

func playerHit():
	lives -= 1
	if lives == 0:
		exploting = true
		$AnimationPlayer.active = true
		$AnimationPlayer.play("Explosion")
