extends Control

func _on_CreateButton_pressed():
	Network.create_server("Player 1")
	_load_game()

func _on_JoinButton_pressed():
	Network.connect_to_server("Player 2", $VBoxContainer/IP.text)
	_load_game()

func _load_game():
	get_tree().change_scene('res://Game.tscn')
