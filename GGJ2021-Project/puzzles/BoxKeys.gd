extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var boxes = []
enum Contents {NOTHING, GLUE, SHOCK, DOORKEY}

class Box:
	var xPos = 0
	var yPos = 0
	var height = 0
	var width = 0
	var id = 0
	var whatsInside = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	generateBoxes(10) #10 is an arbitrary number; decided later

func generateBoxes(numBoxes):
	for n in range(numBoxes+1):
		var newBox = Box.new()
		newBox.id = n
		if n == 0:
			newBox.whatsInside = Contents.DOORKEY
		elif n == 1 || n == 2:
			newBox.whatsInside = Contents.GLUE
		elif n == 3:
			newBox.whatsInside = Contents.SHOCK
		else:
			newBox.whatsInside = Contents.NOTHING
		generateDimensions(newBox)
		boxes.append(newBox)
		generateBoxPositions()
	for box in boxes:
		print(box.whatsInside)
	pass

func generateDimensions(box):
	# generates a random height and width from 5-15
	box.height = randi() % 11 + 5
	box.width = randi() % 11 + 5

func generatePosition(box):
	# generates two random positions 0-100
	box.xPos = randi() % 101
	box.yPos = randi() % 101

func generateBoxPositions():
	for box in boxes:
		if box == boxes[0]:
			generatePosition(box)
		else:
			generatePosition(box)
			while !checkPositionValidity(box):
				generatePosition(box)

func checkPositionValidity(box):
	for boxToCheck in boxes:
		if box == boxToCheck:
			pass
			# axis-aligned bounding box collision checking
		elif box.xPos + box.width > boxToCheck.xPos && box.xPos < boxToCheck.xPos + boxToCheck.width && box.yPos + box.height > boxToCheck.yPos && box.yPos < boxToCheck.yPos + boxToCheck.height:
			return false
		else:
			return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
