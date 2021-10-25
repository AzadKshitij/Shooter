extends Control


func _ready():
	get_tree().connect("connected_to_server",self,"connected")

func connected():
	if not Net.is_host:
		rpc("begin_game")
		begin_game()

#func connected():
#	if Net.is_host and Net.current_players == Net.MAX_PLAYERS:
#		print(Net.current_players)
#		rpc("begin_game")
#		begin_game()
#	else:
#		if not Net.is_host:
#			rpc_id(0, "player_joined")
#
#
#remote func player_joined():
#	Net.current_players += 1
#	connected()

remote func begin_game():
	get_tree().change_scene("res://Asets/Map/Map.tscn")
