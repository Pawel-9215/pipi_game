extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 100
var motion = Vector2.ZERO
var acceleration = 10
var friction = 20
var current_speed = Vector2.ZERO
export var Player_NO = 1

enum {
	MOVE,
	PANIC,
	SAVE
}

var state = MOVE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print("Player %d Ready" % Player_NO)
	
func _physics_process(_delta):
	match state:
		MOVE:
			movement()
		PANIC:
			panic()
		SAVE:
			pass
			
func set_state(set_state):
	var states = {
		"move": MOVE,
		"panic": PANIC,
		"save": SAVE
	}
	print("player", Player_NO, "state: ", set_state)
	state = states[set_state]
	
func calculate_input(Player_nr):
	
	if Player_nr > 2:
		push_error("Invalid player numer.\n Only 2 players handled")
		print(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
		get_tree().quit()
		
	var nrm_motion = Vector2.ZERO
	
	var player = "p"+str(Player_nr)
	
	# get x axis
	if Input.is_action_pressed(player+"_right") and not Input.is_action_pressed(player+"_left"):
		nrm_motion.x = 1
	elif Input.is_action_pressed(player+"_left") and not Input.is_action_pressed(player+"_right"):
		nrm_motion.x = -1
	else:
		nrm_motion.x = 0
	
	# get y axis
	if Input.is_action_pressed(player+"_up") and not Input.is_action_pressed(player+"_down"):
		nrm_motion.y = -1
	elif Input.is_action_pressed(player+"_down") and not Input.is_action_pressed(player+"_up"):
		nrm_motion.y = 1
	else:
		nrm_motion.y = 0
		
	return nrm_motion.normalized()
	
func panic():
	#set panic animation
	pass
	
func movement():
	
	var calculated_input = calculate_input(Player_NO)
	if calculated_input != Vector2.ZERO:
		motion.x = move_toward(motion.x, calculated_input.x*speed, acceleration)
		motion.y = move_toward(motion.y, calculated_input.y*speed, acceleration)
	else:
		motion.x = move_toward(motion.x, 0.0, friction)
		motion.y = move_toward(motion.y, 0.0, friction)
	motion = move_and_slide(motion)
	# print(motion)
		
