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
	if (area.name == "Lower_Bar"):
		bar_reflect(area)
		if (Input.is_action_pressed("lower_left")):
			velocity.x -= 100
		elif (Input.is_action_pressed("lower_right")):
			velocity.x += 100
	elif (area.name == "Upper_Bar"):
		bar_reflect(area)
		if (Input.is_action_pressed("upper_left")):
			velocity.x -= 100
		elif (Input.is_action_pressed("upper_right")):
			velocity.x += 100
	if (area.name == "Left_Wall") or (area.name == "Right_Wall"):
		velocity.x = -velocity.x
	if (area.name == "Safeguard"):
		velocity.x = -velocity.x
		

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("ballDead")

func bar_reflect(area):
	velocity.y = -velocity.y
	velocity.x =  self.get_global_transform().origin.x - area.get_global_transform().origin.x
