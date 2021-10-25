extends Spatial


onready var player1pos = $player1pos
onready var player2pos = $player2pos

# Called when the node enters the scene tree for the first time.
func _ready():
	Net.set_ids()
	creat_players()


func creat_players():
	for id in Net.peer_ids:
		creat_player(id)
	creat_player(Net.net_id)

func creat_player(id):
	var p = preload("res://Asets/Player/Player.tscn").instance()
	add_child(p)
	p.initialize(id)
