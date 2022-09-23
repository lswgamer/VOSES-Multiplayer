extends Area2D

export var id = 1
export var speed = 200
onready var cs = $CollisionShape2D 
onready var sprite = $Sprite
onready var screen_size
onready var anim = $Sprite

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2() 
	if Input.is_action_pressed("lower_right") and (id == 1):
		velocity.x += 1
	elif Input.is_action_pressed("lower_left") and (id == 1):
		velocity.x -= 1
	elif Input.is_action_pressed("upper_right") and (id == 2):
		velocity.x += 1
	elif Input.is_action_pressed("upper_left") and (id == 2):
		velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0+((sprite.get_sprite_frames().get_frame("bar-0",0).get_size().x)/2), screen_size.x-((sprite.get_sprite_frames().get_frame("bar-0",0).get_size().x)/2))
	
