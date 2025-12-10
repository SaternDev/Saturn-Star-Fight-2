class_name PlayerShip
extends CharacterBody2D

signal lifeChanged()

const BULLET = preload("uid://dgw0rxrd8kcyq")

@onready var bullet_spawn: Node2D = $BulletSpawn
@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 220
var lives = 3

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		shoot()
	if animated_sprite_2d.animation == "Explosion":
		if not animated_sprite_2d.is_playing():
			lifeChanged.emit(true)

func _physics_process(_delta: float) -> void:
	var Direction = Input.get_axis("Izquierda","Derecha")
	velocity.x = Direction * speed
	move_and_slide()

func shoot():
	if shoot_cooldown.is_stopped():
		shoot_cooldown.start(0.3)
		
		if BULLET == null:
			return
			
		var bulletInstantiate = BULLET.instantiate()
		bulletInstantiate.position = bullet_spawn.global_position
		get_tree().current_scene.add_child(bulletInstantiate)

func playerHit():
	lives -= 1
	if lives == 0:
		animated_sprite_2d.play("Explosion")
	lifeChanged.emit(false)
