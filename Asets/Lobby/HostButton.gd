extends Button

signal set_connect_type

onready var ip = $ip

func _ready():
	var ip_adress :String
	if OS.get_name() == "Windows":
		ip_adress =  IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)
	elif OS.has_feature("x11"):
		ip_adress =  IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
	elif OS.has_feature("OSX"):
		ip_adress =  IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
	ip.text = "IP: " + ip_adress


func host():
	Net.initialize_server()
	emit_signal("set_connect_type", true)
