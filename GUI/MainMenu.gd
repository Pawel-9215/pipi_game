extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_characters = ["bear", "bunny"]
var player_1_character = 0
var player_2_character = 1

func match_player_characters():
	var animations = {"bear":"bear_idle",
					"bunny":"bunny_idle"}
					
	$player_1_sprite.set_animation(animations[player_characters[player_1_character]])
	$player_2_sprite.set_animation(animations[player_characters[player_2_character]])
	
func change_characters():
	if Input.is_action_pressed("p1_up") and not Input.is_action_pressed("p1_down"):
		print("player 1 input")
		if player_1_character == 1:
			player_1_character = 1
		elif player_1_character < 1:
			player_1_character += 1
			
	match_player_characters()

# Called when the node enters the scene tree for the first time.
func _ready():
	match_player_characters()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
