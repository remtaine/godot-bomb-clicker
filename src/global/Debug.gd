extends Node

func _input(_ev):
	if OS.is_debug_build() and Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
