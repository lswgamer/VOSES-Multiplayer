extends Control

var selector = preload("res://Scenes/LevelSelector.tscn")
onready var grid = $GridContainer

func _ready():
	$AudioStreamPlayer.playing = !Global.ismuted
	if $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play(Global.song_pos)
	for i in range(64):
		var newlevel = selector.instance()
		newlevel.level = i
		var path = "res://Levels/" + str(i+1) +".png"
		var texture = load(path)
		newlevel.preview_texture = texture
		grid.add_child(newlevel)
	


func _on_TextureButton_pressed():
	Global.song_pos = $AudioStreamPlayer.get_playback_position()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("mute"):
		Global.ismuted = !Global.ismuted
		$AudioStreamPlayer.playing = !Global.ismuted
