extends Node2D


# Declare member variables here. Examples:
var value = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().call_group("GUI", "count_total_eggs")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_area_entered(area):
	print("Area entered: ", area)
	var particle_effect = load("res://FX/Collect_egg.tscn").instance()
	particle_effect.global_position = global_position
	get_parent().add_child(particle_effect)
	area.add_item()
	area.count_items()
	self.queue_free()
