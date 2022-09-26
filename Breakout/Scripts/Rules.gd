extends Control

func _process(_delta):
	if Input.is_action_pressed("mute"):
		Global.ismuted = !Global.ismuted
		$AudioStreamPlayer.playing = !Global.ismuted

func _on_ReturnButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
