extends Node2D

var chosen_character
var player_state
onready var player = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_horizontal():
	if player.motion != Vector2.ZERO:
		if player.motion.x < 0 and chosen_character.flip_h == false:
			chosen_character.flip_h = true
		elif player.motion.x > 0 and chosen_character.flip_h:
			chosen_character.flip_h = false
		else:
			pass
			
func move_animations():
	if player.motion.y < 0:
		chosen_character.set_animation("Run_ru")
	elif player.motion.y > 0:
		chosen_character.set_animation("Run_rd")
	elif player.motion == Vector2.ZERO:
		chosen_character.set_animation("Idle")
		
			
func match_animation():
	"""
	var states = {
		"move": MOVE,
		"panic": PANIC,
		"save": SAVE
	}
	"""
	match player_state:
		"move":
			move_animations()
			print("moving")
		"panic":
			chosen_character.set_animation("Attack")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	set_horizontal()
	match_animation()
