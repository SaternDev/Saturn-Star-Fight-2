extends Area2D

var destroying = false
var pointsGain = 2

var life = 5

@onready var gameController = get_tree().current_scene.get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if destroying:
		queue_free()


func _on_shoot_cooldown_timeout() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	print("Body Entered")
	if life < 2:
		if body is Bullet and not destroying:
			body.Destroy()
			destroying = true
			#animated_sprite_2d.play("Explosión")
			gameController.PointsGained(pointsGain)
	else:
		life -= 1
