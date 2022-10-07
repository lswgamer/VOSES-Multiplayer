extends Node2D

@export var nivel = 0
var chosen = 0 #Stores sprite number
var old = -1
var BLOCK_ = preload("res://Scenes/Block.tscn")
var levelList = [] #Stores level configuration
@export var spwOffset = Vector2(0,50)
@onready var lives = 3 #podemos guardar num autoload pra salvar o número de vidas entre fases
@onready var ball = get_node("Ball")
@onready var lowerBar = get_node("Lower_Bar")
@onready var upperBar = get_node("Upper_Bar")
@onready var background = $Background/AnimatedSprite2D
@onready var BGM = $BGM
@onready var SFX = $SFX

func _ready(): #spawna a bola 
	randomize()
	nivel = Global.starting_level
	lives = Global.starting_lives
	ball.position = lowerBar.position - spwOffset
	
	var levels = FileAccess.open("res://Levels/presets.txt", FileAccess.READ) #File has level configuration info
	level_load(levels)
	
	choose_animation(nivel)
	block_spawn(nivel)
	old = -1
	transition_bgm()
	BGM.play()
	BGM.playing = !Global.ismuted
	old = chosen

func _process(_delta):
		check_blocks()
		if Input.is_action_just_pressed("mute"):
			Global.ismuted = !Global.ismuted
			BGM.playing = !Global.ismuted
			if !Global.ismuted:
				Global.has_sfx = true
			else:
				Global.has_sfx = false
		if Global.play_sfx == true:
			SFX.play()
			Global.play_sfx = false
	
#Checa se tem blocos ainda, se não tiver carrega next level
func check_blocks():
	var quantity = len(get_tree().get_nodes_in_group("blocks"))
	if quantity == 0:
		nivel += 1
		choose_animation(nivel)
		block_spawn(nivel)
		transition_bgm()
	
func transition_bgm():
	if old == chosen:
		pass
	else:
		var path = "res://Assets/SFX/sfx-" + str(chosen) +".wav"
		SFX.stream = load(path)
		for _i in range(10):
			await get_tree().create_timer(0.1).timeout
			BGM.volume_db -= 10
		path = "res://Assets/BGM/bgm-" + str(chosen) +".mp3"
		BGM.stream = load(path) 
		BGM.play()
		for _i in range(10):
			await get_tree().create_timer(0.1).timeout
			BGM.volume_db += 10
	
#Randomly generate sprite number and sets animation for bar, ball and panel
func choose_animation(_nivel):
	old = chosen
	chosen = randi()%5 + 1
	if randi()%100 < 2: #1% chance of sprite-0
		chosen = 0
		Global.debug = true
		lowerBar.anim.play("bar-" + str(chosen))
		upperBar.anim.play("bar-" + str(chosen))
	else:
		Global.debug = false
		lowerBar.anim.play("bar-" + str(chosen) + "-1")
		upperBar.anim.play("bar-" + str(chosen) + "-2")
		upperBar.anim.set_flip_h(true)
	
	ball.sprite.play("ball-" + str(chosen))
	background.play("panel-" + str(chosen))

#Spawns block based checked listLevel and call block group to set base animation
func block_spawn(nivel):
	lives += 1
	#print(lives)
	ball.speed = 200 + 100*log(2*nivel+10)
	for i in range(5):
		for j in range(14):
			if levelList[(nivel%64)*5+i][j] == '1':
				var block = BLOCK_.instantiate()
				block.position = Vector2(64*(j+1.5),64*(i+2)+32)
				if randi()%100 < nivel:
					block.hp += 1
					if randi()%100 < nivel:
						block.hp += 1
				add_child(block)
				
			
	get_tree().call_group("blocks", "set_anim", chosen)

func respawn(): #Se a bola sair da tela ela respawna, tirando uma vida
	lives -= 1
	if lives == 0:
		gameover()
	else: #spawna a bola
		if not lives%2: #Odd lives = ball spawns for id=1
			ball.velocity = Vector2(0,1)
			ball.position = lowerBar.position - spwOffset
		else: #Even lives = ball spawns for id=2
			ball.velocity = Vector2(0,-1)
			ball.position = upperBar.position + spwOffset


func gameover(): #cria uma popup com nível alcançado e um botão que te manda pro menu
	ball.queue_free()
	var dialog = AcceptDialog.new()
	dialog.dialog_text = "Game Over!\n You've reached level %s" % (nivel+1)
	add_child(dialog)
	dialog.popup_centered()
	dialog.connect("confirmed",Callable(self,"menu_return"))
	
func menu_return():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

#Stores level configuration from input file
func level_load(file):
	for _i in range(64):
		for _j in range(5):
			levelList.append(file.get_line().split(","))
					
		
