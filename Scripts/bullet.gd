class_name Bullet
extends RigidBody2D


@export var speed = 300.0


func _process(delta: float) -> void:
	position.y -= delta * speed
	
	if position.y < 0:
		Destroy()

func Destroy():
	queue_free()
