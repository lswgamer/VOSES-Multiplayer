extends Node2D

export var nivel = 0
var chosen
var BLOCK_ = preload("res://Scenes/Block.tscn")
var levelList = []
export var spwOffset = Vector2(0,50)
onready var lives = 3 #podemos guardar num autoload pra salvar o número de vidas entre fases
onready var ball = get_node("Ball")
onready var lowerBar = get_node("Lower_Bar")
onready var upperBar = get_node("Upper_Bar")
onready var background = $Background/AnimatedSprite

func _ready(): #spawna a bola 
	randomize()
	
	ball.position = lowerBar.position - spwOffset
	
	var levels = File.new()
	levels.open("res://Levels/presets.txt", File.READ)
	level_load(levels)
	levels.close()
	
	choose_animation(nivel)
	block_spawn(nivel)

func _process(delta):
		check_blocks()
#		print("Next level") # Se matou todos os blocos, passa nivel
	
#Checa se tem blocos ainda, se não tiver carrega next level
func check_blocks():
	var quantity = len(get_tree().get_nodes_in_group("blocks"))
	if quantity == 0:
		nivel += 1
		choose_animation(nivel)
		block_spawn(nivel)
	
func choose_animation(nivel):
	var chosen = randi()%5 + 1
	if randi()%(100-nivel) <= 2:
		chosen = 0
		lowerBar.anim.play("bar-" + str(chosen))
		upperBar.anim.play("bar-" + str(chosen))
	else:
		lowerBar.anim.play("bar-" + str(chosen) + "-1")
		upperBar.anim.play("bar-" + str(chosen) + "-2")
	
	ball.sprite.play("ball-" + str(chosen))
	background.play("bg-" + str(chosen))

func block_spawn(nivel):
	lives += 1
	
	if nivel == 64:
		nivel = 0

	for i in range(5):
		for j in range(14):
			if levelList[nivel*5+i][j] == '1':
				var block = BLOCK_.instance()
				block.position = Vector2(64*(j+1.5),64*(i+2)+32)
				add_child(block)
#				get_node("block").anim.play("block-" + str(chosen) + "-idle")
			

func respawn(): #Se a bola sair da tela ela respawna, tirando uma vida
	lives -= 1
	if lives == 0:
		gameover()
	else: #spawna a bola
		if not lives%2:
			ball.velocity = Vector2(0,1)
			ball.position = lowerBar.position - spwOffset
		else:
			ball.velocity = Vector2(0,-1)
			ball.position = upperBar.position + spwOffset


func gameover(): #cria uma popup com score e te manda pro menu
	ball.queue_free()
	pass

func level_load(file):
	for i in range(64):
		for j in range(5):
			levelList.append(file.get_line().split(","))
					
		
