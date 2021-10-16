extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func update_score(player, value):
	var score

	if len(str(value)) <= 1:
		score = "0"+str(value)
	else:
		score = str(value)
		
	if player == 1:
		$Control/HBoxContainer/P1_score.text = score
	elif player == 2:
		$Control/HBoxContainer/P2_score.text = score
	else:
		print("wrong player no")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
