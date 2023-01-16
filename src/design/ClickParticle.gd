extends CPUParticles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	emitting = true
#	pass
	
func _process(_delta):
	if not self.emitting:
		queue_free()
