extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var xPos = 0
var yPos = 0
var height = 0
var width = 0
var id = 0
var whatsInside = 0
var stolenData


# Called when the node enters the scene tree for the first time.
func _ready():
	var BoxKeysScript = get_node("/root/BoxKeys")
	stolenData = BoxKeysScript.boxes.back()
	xPos = stolenData.xPos
	yPos = stolenData.yPos
	height = stolenData.height
	width = stolenData.width
	id = stolenData.id
	whatsInside = stolenData.whatsInside
	BoxKeysScript.boxes.pop_back()
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
