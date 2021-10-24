extends Button

signal set_connect_type

onready var ip = $IP

func _ready():
	ip.text = "IP: " + str(IP.get_local_addresses()[7])


func host():
	Net.initialize_server()
	emit_signal("set_connect_type", true)
