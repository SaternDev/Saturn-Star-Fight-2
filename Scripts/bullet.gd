class_name Bullet
extends Area2D


@export var speed = 300.0


func _process(delta: float) -> void:
	position.y -= delta * speed
	
	if position.y < 0:
		Destroy()

func Destroy():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Meteor:
		if not body.destroying:
			Destroy()
		body.destroy()
