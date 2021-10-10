extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 100
var motion = Vector2(0, 0)
export var Player_NO = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print("Player %d Ready" % Player_NO)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
