extends Node2D

var boxes = []

enum Contents {NOTHING, GLUE, SHOCK, DOORKEY}

class Box:
	var id # int
	var whatsInside # enum Contents
	var dime # Vector2
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
		print(bodies[n])
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
	var pos = Vector2(randi() % 851,  randi() % 451)
	var valid = boxes.size() == 0
	while !valid:
		valid = true
		var pyrange = range(pos.y, pos.y + box.dime.y)
		for compare in boxes:
			var cyrange = range(compare.posi.y, compare.posi.y + compare.dime.y)
			if range(compare.posi.x, compare.posi.x + compare.dime.x).has(pos.x) && join(pyrange, cyrange).size() < pyrange.size() + cyrange.size():
				valid == false
			elif range(compare.posi.x - compare.dime.x, compare.posi.x).has(pos.x) && join(pyrange, cyrange).size() < pyrange.size() + cyrange.size():
				valid == false
			if !valid:
				pos = Vector2(randi() % 851,  randi() % 451)
				break
	return pos

func generateBox(num, contents):
	var box = Box.new()
	box.id = num
	box.whatsInside = contents
	box.dime = generateDimensions()
	box.posi = generatePosition(box)
	return box
	
func join(arr1, arr2):
	var result = arr1
	for a2 in arr2:
		if !arr1.has(a2):
			result.append(a2)
	return result
