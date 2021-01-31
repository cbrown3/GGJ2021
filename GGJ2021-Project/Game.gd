extends Node

func _ready():
	get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
	get_tree().connect('server_disconnected', self, '_on_server_disconnected')
	
	var new_player
	var id = get_tree().get_network_unique_id()
	
	if id == 1:
		new_player = preload('res://player/Player.tscn').instance()
	else:
		new_player = preload('res://observer/Observer.tscn').instance()
		$CanvasModulate.visible = false
	
	new_player.name = str(id)
	new_player.set_network_master(id)
	add_child(new_player)
	var info = Network.self_data
	new_player.init(info.name, info.position, false)

func _process(delta):
	if Network.players.size() > 1:
		var observer
		_load_cameras(observer)
	pass

func _load_cameras(observer):
	for key in Network.players.keys():
		if key != 1:
			observer = str(key)
	
	if get_node(observer).position == get_node("Camera 1").position:
		get_node("Camera 1/Sprite").texture = load("res://sprites/RCamOn.png")
	elif get_node(observer).position != get_node("Camera 1").position:
		get_node("Camera 1/Sprite").texture = load("res://sprites/RCamOff.png")
	if get_node(observer).position == get_node("Camera 2").position:
		get_node("Camera 2/Sprite").texture = load("res://sprites/RCamOn.png")
	elif get_node(observer).position != get_node("Camera 2").position:
		get_node("Camera 2/Sprite").texture = load("res://sprites/RCamOff.png")
	if get_node(observer).position == get_node("Camera 3").position:
		get_node("Camera 3/Sprite").texture = load("res://sprites/LCamOn.png")
	elif get_node(observer).position != get_node("Camera 3").position:
		get_node("Camera 3/Sprite").texture = load("res://sprites/LCamOff.png")
	if get_node(observer).position == get_node("Camera 4").position:
		get_node("Camera 4/Sprite").texture = load("res://sprites/LCamOn.png")
	elif get_node(observer).position != get_node("Camera 4").position:
		get_node("Camera 4/Sprite").texture = load("res://sprites/LCamOff.png")


func _on_player_disconnected(id):
	get_node(str(id)).queue_free()

func _on_server_disconnected():
	get_tree().change_scene('res://interface/Menu.tscn')
