extends CanvasLayer

@onready var button: Button = $GameOverUI/VBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if button.button_pressed:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn")
