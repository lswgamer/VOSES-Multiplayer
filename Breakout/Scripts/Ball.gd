extends Area2D

var life = 3
var touch = 0
var velocity = Vector2(0.5,1)
export var speed = 200
onready var cs = $CollisionShape2D
onready var sprite = $Sprite
signal ballDead

func _ready():
	position = Vector2(514, 448)

func _process(delta):
	velocity = velocity.normalized() * speed
	position += velocity * delta

func _on_Node2D_area_entered(area):
	if (area.name == "Lower_Bar") or (area.name == "Upper_Bar"):
		velocity.y = -velocity.y
		#Alternativamente velocity.x += etc
		velocity.x =  self.get_global_transform().origin.x - area.get_global_transform().origin.x
	if (area.name == "Left_Wall") or (area.name == "Right_Wall"):
		velocity.x = -velocity.x
		

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("ballDead")

