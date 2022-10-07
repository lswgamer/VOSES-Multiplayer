extends Control

var path

func _ready():
	$AudioStreamPlayer.playing = !Global.ismuted
	if $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play(Global.song_pos)
		
func _process(_delta):
	if Input.is_action_just_pressed("mute"):
		Global.ismuted = !Global.ismuted
		$AudioStreamPlayer.playing = !Global.ismuted

func _on_PlayButton_pressed():
	play_button_press()
	Global.starting_level = 0
	path = "res://Scenes/Level.tscn"
	$Timer.start()
	await $Timer.timeout
	

func _on_CreditsButton_pressed():
	play_button_press()
	path = "res://Scenes/Credits.tscn"
	$Timer.start()
	await $Timer.timeout

func _on_LevelSelectButton_pressed(): #Opens a popup with the level select grid
	play_button_press()
	path = "res://Scenes/LevelSelect.tscn"
	$Timer.start()
	await $Timer.timeout

func _on_SoundButton_pressed(): #Mutes/Unmutes the game, affects other screens
	Global.ismuted = !Global.ismuted
	$AudioStreamPlayer.playing = !Global.ismuted
	play_button_press()


func _on_RulesButton_pressed():
	play_button_press()
	path = "res://Scenes/Rules.tscn"
	$Timer.start()
	await $Timer.timeout


func play_button_press():
	$ButtonSFX.volume_db = -20
	$ButtonSFX.seek(0.2)
	$ButtonSFX.play()


func _on_Timer_timeout():
	if path != "res://Scenes/Level.tscn":
		Global.song_pos = $AudioStreamPlayer.get_playback_position()
# warning-ignore:return_value_discarded
	get_tree().change_scene_to_file(path)
