extends Control

func _process(_delta):
	if Input.is_action_pressed("mute"):
		Global.ismuted = !Global.ismuted
		$AudioStreamPlayer.playing = !Global.ismuted

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Level.tscn")

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")


func _on_LevelSelectButton_pressed(): #Opens a popup with the level select grid
	get_tree().change_scene("res://Scenes/LevelSelect.tscn")


func _on_SoundButton_pressed(): #Mutes/Unmutes the game, affects other screens
	Global.ismuted = !Global.ismuted
	$AudioStreamPlayer.playing = Global.ismuted


func _on_RulesButton_pressed():
	get_tree().change_scene("res://Scenes/Rules.tscn")
