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
	if (area.name == "Lower_Bar") or (area.name == "Upper_Bar"):
		cs.shape.collide_and_get_contacts(cs.transform, area.cs.shape, area.cs.transform)
		#print(area.cs.shape.collide_and_get_contacts(area.cs.transform, cs.shape, cs.transform))
		velocity.y = -velocity.y
		#print(cs.shape, cs.transform, area.cs.shape, area.cs.transform)
		velocity.x = -100 #metade da barra pra esquerda a gente diminui a velocidade entre -1 e 0, metade da barra pra direita a gente aumenta a velocidade entre 0 e 1
		#velocity = -velocity
	if (area.name == "Left_Wall") or (area.name == "Right_Wall"):
		print(area.name)
		velocity.x = -velocity.x
		
