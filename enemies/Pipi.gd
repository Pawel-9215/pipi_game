extends KinematicBody2D

# states for statemachine:
# Patrol, pursuit, attack, numb

var velocity = Vector2()
var patrol_direction = {
	"right": Vector2(1.0, 0.0),
	"left": Vector2(-1.0, 0.0),
	"up": Vector2(0.0, -1.0),
	"down": Vector2(0.0, 1.0),
	"up-right": Vector2(1.0, -1.0),
	"up-left": Vector2(-1.0, -1.0),
	"down-right": Vector2(1.0, 1.0),
	"down-left": Vector2(-1.0, 1.0),
	"stand-still": Vector2.ZERO
}

var detected_player = null

var current_patrol_direction = patrol_direction["right"]

var SPEED = 110
var ACCELERATION = 10
var FRICTION = 20

enum {
	PATROL,
	PURSUIT,
	ATTACK,
	NUMB,
	CONFUSED
}

var state = PATROL

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_state(set_state):
	var states = {
		"patrol": PATROL,
		"pursuit": PURSUIT,
		"attack": ATTACK,
		"numb": NUMB,
		"confused": CONFUSED
	}
	
	state = states[set_state]
	print("pipi state: ", set_state)

func update_movement(input_vector: Vector2, mod_speed):
	input_vector = input_vector.clamped(1.0)
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCELERATION
		velocity = velocity.clamped(SPEED*mod_speed*input_vector.length())
	else:
		velocity = lerp(SPEED*mod_speed*input_vector, Vector2.ZERO, FRICTION)

func _physics_process(_delta):
	match state:
		PATROL:
			patrol_state()
		PURSUIT:
			pursuit_state()
		ATTACK:
			attack_state()
		NUMB:
			numb_state()
		CONFUSED:
			confused_state()
			
func patrol_state():
	update_movement(current_patrol_direction, 0.5)
	velocity = move_and_slide(velocity)
	
func pursuit_state():
	var player_direction = Vector2.ZERO
	if detected_player != null:
		
		player_direction = detected_player.global_position - global_position
	update_movement(player_direction, 0.8)
	velocity = move_and_slide(velocity)

func attack_state():
	#set attack animation
	pass

func confused_state():
	#set confused animation
	pass

func numb_state():
	#after succesful player save
	pass
	

func patrol_direction_raffle():
	#print("Pipi changing direction")
	var direction_enum = {
		1: "right",
		2: "left",
		3: "up",
		4: "down",
		5: "up-right",
		6: "up-left",
		7: "down-right",
		8: "down-left",
		9: "stand-still"
	}
	var new_direction = direction_enum[randi()%9+1]
	var adjacent_walls = $Navigation.get_adjacent_walls()
	
	while new_direction in adjacent_walls:
		new_direction = direction_enum[randi()%9+1]
		
	return new_direction

func _on_PatrolTimer_timeout():
	#change patrol direction

	var new_direction = patrol_direction_raffle()
	#print(new_direction)
	current_patrol_direction = patrol_direction[new_direction]
	$PatrolTimer.start()


func _on_Navigation_body_entered(body):
	if state == PATROL:
		var new_direction = patrol_direction_raffle()
		#print(new_direction)
		current_patrol_direction = patrol_direction[new_direction]
		$PatrolTimer.start()
	elif state == PURSUIT and body == detected_player:
		set_state("attack")
		detected_player.set_state("panic")
	else:
		pass


func _on_PlayerDetection_player_detected(player):
	print("Player detected!", player)
	detected_player = player
	set_state("pursuit")


func _on_PlayerDetection_player_lost():
	print("Player lost")
	set_state("confused")
	detected_player = null
	$ConfusionTimer.start()
	


func _on_ConfusionTimer_timeout():
	print("Confusion wears out")
	set_state("patrol")

func player_saved():
	detected_player.set_state("move")
	set_state("numb")
	detected_player = null
	#start numb timer
