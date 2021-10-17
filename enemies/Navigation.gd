extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var adjacent_walls = {
	"down": false,
	"up": false,
	"left": false,
	"right": false
}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $RayDown.is_colliding():
		adjacent_walls["down"] = true
	else:
		adjacent_walls["down"] = false
		
	if $RayUp.is_colliding():
		adjacent_walls["up"] = true
	else:
		adjacent_walls["up"] = false
		
	if $RayLeft.is_colliding():
		adjacent_walls["left"] = true
	else:
		adjacent_walls["left"] = false
		
	if $RayRight.is_colliding():
		adjacent_walls["right"] = true
	else:
		adjacent_walls["right"] = false


func _on_Navigation_body_entered(body):
	print("Ouh! Pipi hit wall")
	
func get_adjacent_walls():
	var touched_walls = []
	for wall in adjacent_walls:
		if adjacent_walls[wall] == true:
			touched_walls.append(wall)
			
	if adjacent_walls["right"] == true:
		touched_walls.append("down-right")
		touched_walls.append("up-right")
		
	if adjacent_walls["left"] == true:
		touched_walls.append("down-left")
		touched_walls.append("up-left")
		
	if adjacent_walls["up"] == true:
		touched_walls.append("up-right")
		touched_walls.append("up-left")
		
	if adjacent_walls["down"] == true:
		touched_walls.append("down-right")
		touched_walls.append("down-left")
		
	return touched_walls
