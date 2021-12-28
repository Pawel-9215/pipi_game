extends Node2D


var items = 0
var player_no = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player_no = get_parent().Player_NO

func add_item():
	items += 1
	get_tree().call_group("GUI", "update_score", player_no, items)
	
func count_items():
	print(items)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
