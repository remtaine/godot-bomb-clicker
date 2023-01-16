extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var health: int = 0
var amt_on_click: int = 1
var chance_to_multiply: int = 0
var score_multiplier: int = 2
var particle: PackedScene = preload("res://src/design/Click.tscn")

onready var labelHealth: Node = $Health
onready var sfxClick: Node = $SfxClick

# Called when the node enters the scene tree for the first time.
func _ready():
	labelHealth.text = str(health)
	connect("pressed", self, "gainHealth")
	Global.connect("pay_skill", self, "payCost")
	Global.connect("upgrade_skill1", self, "updateSkillVars", [1])
	Global.connect("upgrade_skill2", self, "updateSkillVars", [2])
	Global.connect("upgrade_skill3", self, "updateSkillVars", [3])
	Global.connect("upgrade_skill4", self, "summonPassiveClicker")


func updateSkillVars(added_value, skill_num):
	if skill_num == 1:
		amt_on_click += added_value
		print(amt_on_click)
	if skill_num == 2:
		chance_to_multiply += added_value
	if skill_num == 3:
		Global.emit_signal("increase_time", added_value)
		
func summonPassiveClicker(amt_to_sum):
	for i in amt_to_sum:
		pass #summon a clicker who does gainHealth every second


func gainHealth():
	sfxClick.play()

	var new_particle = particle.instance()
	new_particle.position = get_viewport().get_mouse_position()
	get_tree().get_root().add_child(new_particle)

	var health_increase = 0
	if randi() % 100 < chance_to_multiply:
		health_increase = amt_on_click * score_multiplier
	else:
		health_increase = amt_on_click

	health += health_increase
	Global.emit_signal("bomb_damaged", health_increase)
	Global.emit_signal("character_health_changed", health)
	labelHealth.text = str(health)

func payCost(cost):
	health = max(0, health - cost)
	Global.emit_signal("character_health_changed", health)
	labelHealth.text = str(health)
