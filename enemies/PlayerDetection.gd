extends Area2D

onready var pipi = get_parent()

var player = null
var player_in_fov = false
const MAX_DETECTION_RANGE = 84
var player_detected = false

var detection_status = false

signal player_detected
signal player_lost

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print("mask", collision_mask)

func rotate_area():
	if pipi.velocity != Vector2.ZERO:
		var velocity_norm = pipi.velocity.normalized()
		rotation = atan2(velocity_norm.y, velocity_norm.x)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	rotate_area()
	player_detection()
	
	if player_detected and (detection_status == false):
		detection_status = true
		emit_signal("player_detected", player)
	if (player_detected == false) and (detection_status == true):
		detection_status = false
		emit_signal("player_lost")

func player_detection():
	if player_in_fov and player_in_LOS():
		player_detected = true
	else:
		player_detected = false

func player_in_LOS():
	var space = get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray(global_position, 
											player.global_position, 
											[self, pipi],
											5, true, false)
											
											
	if not LOS_obstacle:
		print("no obstacle", LOS_obstacle)
		return false
	else:
		print("obstacle: ", LOS_obstacle.collider)
		
	var distance_to_player = player.global_position.distance_to(pipi.global_position)
	
	if LOS_obstacle.collider == player: # and distance_to_player <= MAX_DETECTION_RANGE:
		return true
	else:
		return false

func _on_PlayerDetection_body_entered(body):
	print("player in FOV: ", body)
	if player_in_fov == false:
		player_in_fov = true
		player = body
	else:
		pass


func _on_PlayerDetection_body_exited(body):
	if body == player:
		player_in_fov = false
		player = null
