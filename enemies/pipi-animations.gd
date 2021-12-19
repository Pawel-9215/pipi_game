extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pipi = get_parent()
var current_state = "patrol"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_horizontal():
	if pipi.velocity != Vector2.ZERO:
		if pipi.velocity.x < 0 and flip_h == false:
			flip_h = true
		elif pipi.velocity.x > 0 and flip_h:
			flip_h = false
		else:
			pass

func set_state(state):
	
	current_state = state
	
	"""
	var states = {
		"patrol": PATROL,
		"pursuit": PURSUIT,
		"attack": ATTACK,
		"numb": NUMB,
		"confused": CONFUSED
	}
	"""
	
	pass

func _process(_delta):
	
	set_horizontal()
