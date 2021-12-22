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
			
func patrol_animation(): #and pursuit
	
	# var angle = tanh(pipi.velocity.y/pipi.velocity.x)
	
	var angle = rad2deg(get_angle_to(pipi.position + pipi.velocity))
	# print("angle: ", angle)
	
	if pipi.velocity != Vector2.ZERO:
		if angle < -40.0 and angle > -140.0:
			set_animation("run_up")
		elif angle > 40 and angle < 140:
			set_animation("run_down")
		else:
			set_animation("run_right")
		
	
	
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
	if current_state in ["patrol", "pursuit"]:
		patrol_animation()
	if current_state == "attack":
		set_animation("attacking")
	elif current_state == "numb":
		set_animation("dizzy")
	elif current_state == "confused":
		set_animation("confused")
