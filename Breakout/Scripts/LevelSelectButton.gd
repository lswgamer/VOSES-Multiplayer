extends Control

export var level = 0
var preview_texture : Texture
onready var preview = $LevelPreviewButton

func _ready():
	preview.texture_normal = preview_texture

func _on_LevelPreviewButton_pressed():
	Global.starting_level = level
	get_tree().change_scene("res://Scenes/Level.tscn")
