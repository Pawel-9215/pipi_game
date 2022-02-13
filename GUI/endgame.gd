extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var who_won = "nobody"

var player_1_avatar
var player_2_avatar

func print_winner():
	$TextureRect/WinnerTag.set_new_text(who_won + "won the game")
	
func load_scoreboard():
	var scoreboard = File.new()
	if not scoreboard.file_exists("user://scoreboard"):
		return # Error, no save data!
	scoreboard.open("user://scoreboard", File.READ)
	
	var winners = parse_json(scoreboard.get_line())
	print(winners)
	scoreboard.close()
	

	if winners["pipi"] == 9999:
		who_won = "Pipi"
	else:
		if winners["player_1"] > winners["player_2"]:
			who_won = "Player One"
		else:
			who_won = "Player Two"
			
func set_frontend():
	
	$TextureRect/WinnerTag.set_new_text(who_won+ " won")
	if who_won == "Pipi":
		$TextureRect/WinnerSprite.set_animation("pipi")
		$TextureRect/WinnerTag.global_position.x += 16
	elif who_won == "Player One":
		$TextureRect/WinnerSprite.set_animation(player_1_avatar)
	elif who_won == "Player Two":
		$TextureRect/WinnerSprite.set_animation(player_2_avatar)

func load_player_data():
	var player_data = File.new()
	if not player_data.file_exists("user://savedplayers"):
		return # Error, no save data!
	player_data.open("user://savedplayers", File.READ)
	
	var players = parse_json(player_data.get_line())
	player_1_avatar = players["player_1_character"]
	player_2_avatar = players["player_2_character"]
	
	
	player_data.close()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	load_player_data()
	load_scoreboard()
	print(who_won, " WON the game")
	set_frontend()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://GUI/level_chooser.tscn")
