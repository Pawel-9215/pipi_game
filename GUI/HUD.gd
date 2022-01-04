extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var match_score = {"player_1":0, "player_2":0, "pipi":0}
var player_under_attack = false
var pipi_wins = false
var golden_eggs_collected = 0
var total_golden_eggs = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	
func player_is_attacked(is_he):
	print("player under attack: ", is_he)
	player_under_attack = is_he
	
func count_total_eggs():
	total_golden_eggs += 1
	
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
		match_score["player_1"] = value
		$Control/HBoxContainer/P1_score.text = score
	elif player == 2:
		match_score["player_2"] = value
		$Control/HBoxContainer/P2_score.text = score
	else:
		print("wrong player no")
		
	golden_eggs_collected = int(match_score["player_1"]) + int(match_score["player_2"]) 
	
	if golden_eggs_collected == total_golden_eggs:
		end_match()
		
func end_match():
	print("Game ended")
	save_scoreboard_data()
	get_tree().change_scene("res://GUI/endgame.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
