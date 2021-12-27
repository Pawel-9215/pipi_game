extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_characters = ["bear", "bunny"]
var player_1_character = 0
var player_2_character = 1

func save_player_data():
	var player_data = {
		"player_1_character": player_characters[player_1_character],
		"player_2_character": player_characters[player_2_character]
	}
	
	var saved_players = File.new()
	saved_players.open("user://savedplayers", File.WRITE)
	saved_players.store_line(to_json(player_data))
	saved_players.close()
	
func load_player_data():
	var player_data = File.new()
	if not player_data.file_exists("user://savedplayers"):
		return # Error, no save data!
	player_data.open("user://savedplayers", File.READ)
	
	var players = parse_json(player_data.get_line())
	var player_1 = players["player_1_character"]
	var player_2 = players["player_2_character"]
	
	print(player_1, player_2)
	
	player_data.close()

func match_player_characters():
	var animations = {"bear":"bear_idle",
					"bunny":"bunny_idle"}
					
	$player_1_sprite.set_animation(animations[player_characters[player_1_character]])
	$player_2_sprite.set_animation(animations[player_characters[player_2_character]])
	
func change_characters():
	if Input.is_action_just_pressed("p1_up"):
		#print("player 1 input")
		if player_1_character == 1:
			player_1_character = 0
		elif player_1_character < 1:
			player_1_character += 1
	elif Input.is_action_just_pressed("p1_down"):
		if player_1_character == 0:
			player_1_character = 1
		elif player_1_character > 0:
			player_1_character -= 1
			
	if Input.is_action_just_pressed("p2_up"):
		#print("player 1 input")
		if player_2_character == 1:
			player_2_character = 0
		elif player_2_character < 1:
			player_2_character += 1
	elif Input.is_action_just_pressed("p2_down"):
		if player_2_character == 0:
			player_2_character = 1
		elif player_2_character > 0:
			player_2_character -= 1
			
	match_player_characters()
	
func start_game():
	if Input.is_action_just_pressed("ui_accept"):
		save_player_data()
		#load_player_data()
		get_tree().change_scene("res://prototype_levels/Test_scene_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	match_player_characters()
	save_player_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	change_characters()
	start_game()
