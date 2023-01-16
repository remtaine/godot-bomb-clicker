class_name Skill
extends Button


var level: int = 0

export var value: int = 0
export var added_value: int = 0

export var skill_num = 0
var description_text_template = ""
export var cost: int = 10
export var cost_adder: int = 10
export var cost_multiplier: float = 2


func _ready():
	connect("pressed", self, "upgrade")
	Global.connect("character_health_changed", self, "check_price")
	description_text_template = $VBoxContainer/Description.text
	update_text()

	
func check_price(new_health):
	if cost > new_health:
		disabled = true
	else:
		disabled = false
		
		
func upgrade():
	Global.emit_signal("pay_skill", cost)
	value += added_value
	Global.emit_signal("upgrade_skill" + str(skill_num), added_value)
	
	level += 1
	cost = int(cost * cost_multiplier)
	cost += cost_adder

	update_text()
	$Sfx/Click.play()


func update_text():
	$VBoxContainer/Description.text = description_text_template.replace("XXX", str(added_value)).replace("YYY", str(value))
	$VBoxContainer/HBoxContainer/Cost.text = "Cost: " + str(cost)
	$VBoxContainer/HBoxContainer/Level.text = "Lvl " + str(level)
