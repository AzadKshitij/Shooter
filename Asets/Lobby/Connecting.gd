extends ColorRect


const CONNECT_TEXT = ["Waiting for players...", "Connecting to server..."]


onready var connecting_lable = $Connectinglable

func set_connect_type(host):
	show()
	if host:
		connecting_lable.text = CONNECT_TEXT[0]
	else:
		connecting_lable.text = CONNECT_TEXT[1]
