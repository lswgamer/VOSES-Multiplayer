extends Control

func _ready():
	$AudioStreamPlayer.playing = !Global.ismuted
	if $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play(Global.song_pos)
		
func _process(_delta):
	if Input.is_action_just_pressed("mute"):
		Global.ismuted = !Global.ismuted
		$AudioStreamPlayer.playing = !Global.ismuted

func _on_PlayButton_pressed():
	Global.starting_level = 0
	get_tree().change_scene("res://Scenes/Level.tscn")
	

func _on_CreditsButton_pressed():
	Global.song_pos = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene("res://Scenes/Credits.tscn")

func _on_LevelSelectButton_pressed(): #Opens a popup with the level select grid
	Global.song_pos = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene("res://Scenes/LevelSelect.tscn")

func _on_SoundButton_pressed(): #Mutes/Unmutes the game, affects other screens
	Global.ismuted = !Global.ismuted
	$AudioStreamPlayer.playing = !Global.ismuted


func _on_RulesButton_pressed():
	Global.song_pos = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene("res://Scenes/Rules.tscn")
