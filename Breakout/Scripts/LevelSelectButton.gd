extends Control

@export var level = 0
var preview_texture : Texture2D
@onready var preview = $LevelPreviewButton

func _ready():
	preview.texture_normal = preview_texture

func _on_LevelPreviewButton_pressed():
	Global.starting_level = level
# warning-ignore:return_value_discarded
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")
