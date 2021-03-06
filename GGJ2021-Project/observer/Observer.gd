extends Node2D

var cameras = { }

var camPos = 0

enum CameraSwitch { LEFT, RIGHT, NONE }

slave var slave_position = Vector2()
slave var slave_movement = CameraSwitch.NONE

func _ready():
	var children = get_parent().get_children()
	var i = 0
	for node in children:
		if node.name.begins_with("Camera "):
			cameras[i] = node
			i+= 1
		

func _process(delta):
	var direction = CameraSwitch.NONE
	if is_network_master():
		if Input.is_action_just_pressed('left'):
			direction = CameraSwitch.LEFT
		elif Input.is_action_just_pressed('right'):
			direction = CameraSwitch.RIGHT
		$Camera2D.make_current()
		
		rset_unreliable('slave_position', position)
		rset('slave_movement', direction)
		_move(direction)
	else:
		_move(slave_movement)
		position = slave_position
	
	if get_tree().is_network_server():
		Network.update_position(int(name), position)

func _move(direction):
	match direction:
		CameraSwitch.NONE:
			return
		CameraSwitch.LEFT:
			cameras[camPos].get_child(2).play()
			camPos -= 1
			if camPos < 0:
				camPos = 3
			transform = cameras[camPos].transform
			cameras[camPos].get_child(1).play()
		CameraSwitch.RIGHT:
			cameras[camPos].get_child(2).play()
			camPos += 1
			if camPos > 3:
				camPos = 0
			transform = cameras[camPos].transform
			cameras[camPos].get_child(1).play()

func init(nickname, start_position, is_slave):
	$ObserverGUI/Nickname.text = ""
	global_position = start_position
