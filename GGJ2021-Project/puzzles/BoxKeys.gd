extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var boxes = []
enum Contents {DOORKEY, GLUE, SHOCK, NOTHING}

class Box:
	var xPos = 0
	var yPos = 0
	var id
	var whatsInside

# Called when the node enters the scene tree for the first time.
func _ready():
	generateBoxes(10)

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
		boxes.append(newBox)
	for box in boxes:
		print(box.whatsInside)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
