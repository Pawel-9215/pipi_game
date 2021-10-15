extends Node2D


# Declare member variables here. Examples:
var value = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_area_entered(area):
	print("Area entered: ", area)
	area.add_item(self)
	area.count_items()
	self.queue_free()
