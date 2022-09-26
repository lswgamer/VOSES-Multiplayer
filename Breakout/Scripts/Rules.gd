extends Control

func _ready():
	$AudioStreamPlayer.playing = !Global.ismuted
	if $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play(Global.song_pos)

func _process(_delta):
	if Input.is_action_just_pressed("mute"):
		Global.ismuted = !Global.ismuted
		$AudioStreamPlayer.playing = !Global.ismuted

func _on_ReturnButton_pressed():
	Global.song_pos = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
