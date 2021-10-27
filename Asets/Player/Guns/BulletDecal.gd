extends Spatial

onready var timer = $Timer

func _ready():
	timer.connect("timeout",self,"queue_free")
	
