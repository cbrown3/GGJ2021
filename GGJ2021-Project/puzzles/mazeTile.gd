extends Node2D

var safeTexture = preload("res://sprites/mazeTileSafe.png")
var isSafe = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func makeSafe():
	isSafe = true
