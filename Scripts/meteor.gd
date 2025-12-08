class_name Meteor
extends RigidBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gameController = get_tree().current_scene.get_child(0)
@onready var game_ui = get_tree().current_scene.get_child(1)

var destroying = false
@export var speed = 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not destroying:
		position.y += delta * speed
	
	if animated_sprite_2d.frame == 3:
		queue_free()


func _on_body_entered(body: Node) -> void:
	if body is Bullet:
		body.Destroy()
		destroying = true
		animated_sprite_2d.play("Explosión")
		gameController.PointsGained()
		
	if body is PlayerShip:
		destroying = true
		animated_sprite_2d.play("Explosión")
		animated_sprite_2d.speed_scale = 3
		gameController.PointsGained()
		body.playerHit()
