extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var match_score = {"player_1":0, "player_2":0, "pipi":0}
var player_under_attack = false
var pipi_wins = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func save_scoreboard_data():

	var scoreboard = File.new()
	scoreboard.open("user://scoreboard", File.WRITE)
	scoreboard.store_line(to_json(match_score))
	scoreboard.close()
	
func update_score(player, value):
	if player_under_attack:
		pipi_wins = true
		match_score["pipi"] = 9999
		end_match()
		return
		
	var score

	if len(str(value)) <= 1:
		score = "0"+str(value)
	else:
		score = str(value)
		
	if player == 1:
		match_score["player_1"] = score
		$Control/HBoxContainer/P1_score.text = score
	elif player == 2:
		match_score["player_2"] = score
		$Control/HBoxContainer/P2_score.text = score
	else:
		print("wrong player no")
		
func end_match():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
