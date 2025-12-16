class_name Meteor
extends RigidBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gameController = get_tree().current_scene.get_child(0)
@onready var game_ui = get_tree().current_scene.get_child(1)

var destroying = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed = get_parent().MeteorSpeed
	
	if position.y > 650:
		queue_free()
	
	#Handle Meteor Movement
	if not destroying:
		position.y += delta * speed
	
	#Waits untill the animation of destroying stops and delets de nodedad
	if not animated_sprite_2d.is_playing() and destroying:
		queue_free()


func _on_body_entered(body: Node) -> void:
	if body is Bullet and not destroying:
		body.Destroy()
		destroying = true
		animated_sprite_2d.play("Explosión")
		gameController.PointsGained()
		
	if body.is_in_group("Players"):
		destroying = true
		animated_sprite_2d.play("Explosión")
		animated_sprite_2d.speed_scale = 3
		body.playerHit()
