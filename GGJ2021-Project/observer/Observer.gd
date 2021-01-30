extends KinematicBody2D

const MOVE_SPEED = 10.0

enum MoveDirection { UP, DOWN, LEFT, RIGHT, NONE }

slave var slave_position = Vector2()
slave var slave_movement = MoveDirection.NONE


func _ready():
	pass

func _physics_process(delta):
	var direction = MoveDirection.NONE
	if is_network_master():
		if Input.is_action_pressed('left'):
			direction = MoveDirection.LEFT
		elif Input.is_action_pressed('right'):
			direction = MoveDirection.RIGHT
		elif Input.is_action_pressed('up'):
			direction = MoveDirection.UP
		elif Input.is_action_pressed('down'):
			direction = MoveDirection.DOWN
		
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
		MoveDirection.NONE:
			return
		MoveDirection.UP:
			move_local_y(-MOVE_SPEED)
		MoveDirection.DOWN:
			move_local_y(MOVE_SPEED)
		MoveDirection.LEFT:
			move_local_x(-MOVE_SPEED)
		MoveDirection.RIGHT:
			move_local_x(MOVE_SPEED)

func init(nickname, start_position, is_slave):
	$GUI/Nickname.text = nickname
	global_position = start_position
