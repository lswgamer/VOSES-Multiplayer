extends Node2D

export var spwOffset = Vector2(0,50)
onready var lives = 3 #podemos guardar num autoload pra salvar o número de vidas entre fases
onready var ball = get_node("Ball")
onready var lowerBar = get_node("Lower_Bar")

func _ready(): #spawna a bola 
	ball.position = lowerBar.position - spwOffset
	
#Checa se tem blocos ainda, se não tiver carrega next level
func check_blocks():
	pass

func respawn(): #Se a bola sair da tela ela respawna, tirando uma vida
	lives -= 1
	if lives == 0:
		gameover()
	else: #spawna a bola
		ball.position = lowerBar.position - spwOffset


func gameover(): #cria uma popup com score e te manda pro menu
	ball.queue_free()
	pass

