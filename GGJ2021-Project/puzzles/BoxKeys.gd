extends Node


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
	pass # Replace with function body.

	
func generateBoxes():
	for n in range(11):
		boxes[n] = Box.new()
		boxes[n].id = n
		if n == 0:
			boxes[n].whatsInside = Contents.DOORKEY
		elif n == 1 || n == 2:
			boxes[n].whatsInside = Contents.GLUE
		elif n == 3:
			boxes[n].whatsInside = Contents.SHOCK
		else:
			boxes[n].whatsInside = Contents.NOTHING

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
