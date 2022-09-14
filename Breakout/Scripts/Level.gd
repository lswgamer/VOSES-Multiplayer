extends Node2D

onready var lives = 3 #podemos guardar num autoload pra salvar o número de vidas entre fases

func _ready(): #spawna a bola 
	pass
	
#Checa se tem blocos ainda, se não tiver carrega next level
func check_blocks():
	pass

func respawn(): #Se a bola sair da tela ela respawna, tirando uma vida
	lives -= 1
	if lives == 0:
		gameover()
	else: #spawna a bola
		pass


func gameover(): #cria uma popup com score e te manda pro menu
	pass

