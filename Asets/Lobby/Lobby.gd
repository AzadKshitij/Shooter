extends Control


func _ready():
	get_tree().connect("connected_to_server",self,"connected")

func connected():
	if not Net.is_host:
		rpc("begin_bame")
		begin_game()

remote func begin_game():
	get_tree().change_scene("res://Asets/Map/Map.tscn")
