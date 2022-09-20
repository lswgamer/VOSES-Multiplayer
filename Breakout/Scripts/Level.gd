extends Node2D

var BLOCK_ = preload("res://Scenes/Block.tscn")
export var spwOffset = Vector2(0,50)
onready var lives = 3 #podemos guardar num autoload pra salvar o número de vidas entre fases
onready var ball = get_node("Ball")
onready var lowerBar = get_node("Lower_Bar")

func _ready(): #spawna a bola 
	ball.position = lowerBar.position - spwOffset
	block_spawn()

func _process(delta):
	var quantity = len(get_tree().get_nodes_in_group("blocks"))
	if quantity == 0:
		print("Next level") # Se matou todos os blocos, passa nivel
	
#Checa se tem blocos ainda, se não tiver carrega next level
func check_blocks():
	pass
	
func block_spawn():
	for i in range(2,7):
		for j in range(2,14):
			var block = BLOCK_.instance()
			block.position = Vector2(64*j,64*i+32)
			add_child(block)
			

func respawn(): #Se a bola sair da tela ela respawna, tirando uma vida
	lives -= 1
	if lives == 0:
		gameover()
	else: #spawna a bola
		ball.position = lowerBar.position - spwOffset


func gameover(): #cria uma popup com score e te manda pro menu
	ball.queue_free()
	pass

