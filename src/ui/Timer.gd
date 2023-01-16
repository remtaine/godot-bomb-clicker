extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time_left = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("increase_time", self, "increase_time")


func _process(_delta):
	updateTimerText()
	if time_left == 0:
		Global.emit_signal("game_end")
		$Explosion.play()


func increase_time(added_value):
	$Timer.start($Timer.get_time_left() + added_value)
	updateTimerText()
	
func updateTimerText():
	time_left = int($Timer.get_time_left())
	text = "Time: \n" + str(time_left)
