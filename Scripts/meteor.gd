class_name Meteor
extends RigidBody2D

var pointsGain = 1

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gameController = get_tree().current_scene.get_child(0)
@onready var game_ui = get_tree().current_scene.get_child(1)

var destroying = false

func _ready() -> void:
	animated_sprite_2d.play("Idle")

# Se usa _physics_process para manejar elementos físicos como RigidBody2D
func _physics_process(_delta: float) -> void:
	# Si sobrepasa la pantalla, se elimina
	if position.y > 650:
		queue_free()
	
	# Manejo del movimiento mediante físicas
	if not destroying:
		var speed = get_parent().MeteorSpeed
		linear_velocity.y = speed
	else:
		freeze = true
		linear_velocity = Vector2.ZERO
	
	# Espera a que termine la animación de destrucción para borrar el nodo
	if not animated_sprite_2d.is_playing() and destroying:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body is Bullet and not destroying:
		body.Destroy()
		destroying = true
		animated_sprite_2d.play("Explosión")
		gameController.PointsGained(pointsGain)
	
	if body.is_in_group("Players"):
		if not destroying: 
			body.playerHit()
		destroying = true
		animated_sprite_2d.play("Explosión")
		animated_sprite_2d.speed_scale = 3
