extends TextureRect


var health: int = 1000
onready var labelHealth: Node = $Health


func _ready():
	labelHealth.text = str(health)
	Global.connect("bomb_damaged", self, "updateHealth")

func updateHealth(damage):
	health -= damage
	$Health.text = str(health)
