extends Node2D

export var nivel = 0
var BLOCK_ = preload("res://Scenes/Block.tscn")
var levelList = []
export var spwOffset = Vector2(0,50)
onready var lives = 3 #podemos guardar num autoload pra salvar o número de vidas entre fases
onready var ball = get_node("Ball")
onready var lowerBar = get_node("Lower_Bar")

func _ready(): #spawna a bola 
	ball.position = lowerBar.position - spwOffset
	var levels = File.new()
	levels.open("res://Levels/presets.py", File.READ)
	level_load(levels)
	levels.close()
	block_spawn(nivel)

func _process(delta):
		check_blocks()
#		print("Next level") # Se matou todos os blocos, passa nivel
	
#Checa se tem blocos ainda, se não tiver carrega next level
func check_blocks():
	var quantity = len(get_tree().get_nodes_in_group("blocks"))
	if quantity == 0:
		nivel += 1
		block_spawn(nivel)
	
func block_spawn(nivel):
	if nivel == 64:
		nivel = 0

	for i in range(5):
		for j in range(14):
			if levelList[nivel*5+i][j] == '1':
				var block = BLOCK_.instance()
				block.position = Vector2(64*(j+1.5),64*(i+2)+32)
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

func level_load(file):
	for i in range(64):
		for j in range(5):
			levelList.append(file.get_line().split(","))
					
		
