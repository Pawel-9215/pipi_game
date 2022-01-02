tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var text: String = "typehere"
var full_text = []
var alphabet = {"a":0, "b":1, "c":2, "d":3, "e":4, "f":5, "g":6, "h":7, "i":8, "j":9,
"k":10, "l":11, "m":12, "n":13, "o":14, "p":15, "q":16, "r":17, "s":18, "t":19, "u":20,
"w":21, "x":22, "y":23, "z":24, " ":25}


# Called when the node enters the scene tree for the first time.
func _ready():
	text = text.to_lower()
	
	for letter in text:
		full_text.append($letter.duplicate())
		
	for index in full_text.size():
		add_child(full_text[index])
		full_text[index].global_position.x += 5*index
		full_text[index].frame = alphabet[text[index]]
		
	$letter.visible = false
	
func clear_text():
	for letter in full_text:
		remove_child(letter)
		letter.queue_free()

func set_new_text(new_text):
	clear_text()
	full_text = []
	var local_text = new_text.to_lower()
	
	for letter in local_text:
		full_text.append($letter.duplicate())
		
	for index in full_text.size():
		add_child(full_text[index])
		full_text[index].global_position.x += 5*index
		full_text[index].frame = alphabet[text[index]]
		
	$letter.visible = false
		
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
