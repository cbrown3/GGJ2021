extends Node2D

var boxes = []

enum Contents {NOTHING, GLUE, SHOCK, DOORKEY}

class Box:
	var id # int
	var whatsInside # enum Contents
	var posi # Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	var static_bodies = []
	for child in children:
		if typeof(StaticBody2D):
			static_bodies.append(child)
	generateBoxes(static_bodies)

func generateBoxes(bodies):
	for n in range(bodies.size()):
		var box = generateBox(n, decideContents(n))
		boxes.append(box)
		bodies[n].position = box.posi
		
func decideContents(num):
	if num == 0:
		return Contents.DOORKEY
	elif num == 1 || num == 2:
		return Contents.GLUE
	elif num == 3:
		return Contents.SHOCK
	else:
		return Contents.NOTHING
	
func generateDimensions():
	# generates a random width and height from 5-15
	randomize()
	return Vector2(randi() % 11 + 5, randi() % 11 + 5)

func generatePosition(box):
	randomize()
	var pos = Vector2(randi() % 1751,  randi() % 1001)
	var valid = boxes.size() == 0
	while !valid:
		valid = true
		for compare in boxes:
			if compare.posi.x <= pos.x && compare.posi.x + 200 >= pos.x:
				if compare.posi.y <= pos.y && compare.posi.y + 200 >= pos.y:
					valid = false
				elif compare.posi.y >= pos.y && compare.posi.y - 200 <= pos.y:
					valid = false
			elif compare.posi.x >= pos.x && compare.posi.x - 200 <= pos.x:
				if compare.posi.y >= pos.y && compare.posi.y - 200 <= pos.y:
					valid = false
				elif compare.posi.y <= pos.y && compare.posi.y + 200 >= pos.y:
					valid = false
			if !valid:
				pos = Vector2(randi() % 1751,  randi() % 1001)
				break
	return pos

func generateBox(num, contents):
	var box = Box.new()
	box.id = num
	box.whatsInside = contents
	box.posi = generatePosition(box)
	return box
