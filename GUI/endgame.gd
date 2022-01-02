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
	if not scoreboard.file_exists("user://savedplayers"):
		return # Error, no save data!
	scoreboard.open("user://savedplayers", File.READ)
	
	var winners = parse_json(scoreboard.get_line())
	
	print(winners)
	
	
	
	scoreboard.close()

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
