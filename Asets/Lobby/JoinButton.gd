extends Button

signal set_connect_type

onready var ip = $ip
onready var invalid_ip = $"invalid Ip lable"

func _on_JoinButton_pressed():
	if ip.text.is_valid_ip_address():
		join()
	else:
		invalid_ip.show()


func join():
	Net.initialize_client(ip.text)
	emit_signal("set_connect_type", false)
