extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var registered_levels = [
	"res://maps/flat_01",
	"res://maps/flat_02"
]

var choosen_map = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func toggle_levels(): #add p2 later
	if Input.is_action_just_pressed("p1_right"):
		choosen_map_toggle("+")
		print(choosen_map)
		display_image()
	elif Input.is_action_just_pressed("p1_left"):
		choosen_map_toggle("-")
		print(choosen_map)
		display_image()
	elif Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene(registered_levels[choosen_map]+".tscn")
		
func choosen_map_toggle(direction):
	if direction == "+":
		if choosen_map == registered_levels.size()-1:
			choosen_map = 0
		else:
			choosen_map += 1
	elif direction == "-":
		if choosen_map == 0:
			choosen_map = registered_levels.size()-1
		else:
			choosen_map -= 1
			
func display_image():
	$TextureRect/LevelLogo.set_texture(load(registered_levels[choosen_map]+".png"))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	toggle_levels()

