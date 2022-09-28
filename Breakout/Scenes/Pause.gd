extends Control

var paused = false

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		if paused  == true:
			get_tree().paused = true
		else:
			get_tree().paused = false
