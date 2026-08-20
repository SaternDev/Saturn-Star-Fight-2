extends Area2D

var destroying = false
var pointsGain = 2

var life = 5
var speed = 150

#Si es 0 es izquierda si es 1 es derecha
var direction:bool

@onready var gameController = get_tree().current_scene.get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Ejecuta la animación normal
	$AnimatedSprite2D.play("default")
	# Decide aleatoriamente hacia donde ir la nave
	direction = randi_range(0,1)


# Realiza el calculo para mover la nave
func _process(delta: float) -> void:
	# Se mueve hacia la izquierda
	if direction == false:
		position.x -= delta * speed
		# Verifica que no se pase del limite lateral
		if global_position.x < 32:
			direction = 1
	# Se mueve hacia la derecha
	else:
		position.x += delta * speed
		# Verifica que no se pase del limite lateral
		if global_position.x > 298:
			direction = 0

func _physics_process(_delta: float) -> void:
	if destroying:
		GlobalSave.game_data["AliensKilled"] += 1
		queue_free()


func _on_shoot_cooldown_timeout() -> void:
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	if life < 2:
		if area is Bullet and not destroying:
			area.queue_free()
			destroying = true
			#animated_sprite_2d.play("Explosión")
			gameController.PointsGained(pointsGain)
	else:
		area.queue_free()
		life -= 1
