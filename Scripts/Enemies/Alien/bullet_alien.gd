class_name Bullet_alien
extends Area2D

@export var speed = 350.0

func _process(delta: float) -> void:
	position.y += delta * speed
	
	if global_position.y > 610:
		Destroy()

func Destroy():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		body.playerHit()
		Destroy()
