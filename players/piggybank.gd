extends Node2D


var items = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_item(item):
	items.append(item)
	
func count_items():
	print(len(items))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
