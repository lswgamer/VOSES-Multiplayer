extends Area2D

var velocity = Vector2(0,1)
export var speed = 200
onready var cs = $CollisionShape2D
onready var sprite = $Sprite

func _ready():
	position = Vector2(512, 448)

func _process(delta):
	velocity = velocity.normalized() * speed
	position += velocity * delta

func _on_Node2D_area_entered(area):
	if area.name == "Lower_Bar" or "Upper_Bar":
		velocity = -velocity
