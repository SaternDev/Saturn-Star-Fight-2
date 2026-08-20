extends Area2D

var destroying = false
var pointsGain = 2
var life = 5

const BULLET_ALIEN = preload("uid://d1idj2mari4iu")
const ALIEN_SHOOT_SOUND = preload("uid://bd4tiayvwlur4")
@onready var soundPlayer: AudioStreamPlayer = $Sounds

@onready var gameController = get_tree().current_scene.get_child(0)
@onready var bullet_spawn: Node2D = $BulletSpawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if destroying:
		GlobalSave.game_data["AliensKilled"] += 1
		queue_free()


func _on_shoot_cooldown_timeout() -> void:
	playSound(ALIEN_SHOOT_SOUND)
	var bullet_alienInstantiate = BULLET_ALIEN.instantiate()
	bullet_alienInstantiate.position = bullet_spawn.global_position
	get_tree().current_scene.add_child(bullet_alienInstantiate)
	$ShootCooldown.start(5)

func _on_area_entered(area: Area2D) -> void:
	print("Body Entered")
	if life < 2:
		if area is Bullet and not destroying:
			area.queue_free()
			destroying = true
			#animated_sprite_2d.play("Explosión")
			gameController.PointsGained(pointsGain)
	elif area is Bullet:
		area.queue_free()
		life -= 1

func playSound(selectedSound):
	soundPlayer.stream = selectedSound
	soundPlayer.play()
