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
	play_button_press()
	$Timer.start()
	yield($Timer, "timeout")
	
	
func play_button_press():
	$ButtonSFX.volume_db = -20
	$ButtonSFX.seek(0.2)
	$ButtonSFX.play()
	#yield(get_tree().create_timer(0.3), "timeout")


func _on_Timer_timeout():
	Global.song_pos = $AudioStreamPlayer.get_playback_position()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
