extends Node2D


onready var step_sounds = [$step_1, $step_2, $step_3]
onready var player = get_parent()

var is_running = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_steps():
	var next_sound = step_sounds[randi() % step_sounds.size()]
	next_sound.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player.get_state() == "move" and player.motion != Vector2.ZERO:
		is_running = true
	else:
		is_running = false


func _on_StepTime_timeout():
	if is_running:
		play_steps()
