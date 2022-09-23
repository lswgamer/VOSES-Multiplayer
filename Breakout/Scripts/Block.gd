extends AnimatedSprite

export var hp = 1
export var fade = 0 #Fade-out speed
onready var anim = self 
onready var blockDead = false #Checks if block was destroyed
onready var blockValue = 0 #Stores sprite number

func _process(delta):
	#Fade-out effect (when fade != 0)
	var cor = Color(get_modulate())
	cor -= Color(0,0,0,fade*delta)
	set_modulate(cor)
	

func remove():
	#Runs when animation ends
	#If block is dead (and animation not playing anymore)
	if blockDead:
		self.queue_free()

func _on_Up_area_entered(area):
	if (area.name == "Ball" and !blockDead):
		area.velocity.y = -abs(area.velocity.y)
		hp -= hp
		if hp == 0:
			if blockValue > 0:
				break_animation(blockValue)
			else: #sprite-0 has no break animation
				blockDead = true
				remove()

func _on_Down_area_entered(area):
	if (area.name == "Ball" and !blockDead):
		area.velocity.y = abs(area.velocity.y) 
		hp -= hp
		if hp == 0:
			if blockValue > 0:
				break_animation(blockValue)
			else:
				blockDead = true
				remove()
		
func _on_Left_area_entered(area):
	if (area.name == "Ball" and !blockDead):
		area.velocity.x = -abs(area.velocity.x)
		hp -= hp
		if hp == 0:
			if blockValue > 0:
				break_animation(blockValue)
			else:
				blockDead = true
				remove()
		
func _on_Right_area_entered(area):
	if (area.name == "Ball" and !blockDead):
		area.velocity.x = abs(area.velocity.x)
		hp -= hp
		if hp == 0:
			if blockValue > 0:
				break_animation(blockValue)
			else:
				blockDead = true
				remove()

func break_animation(blockValue):
	#Plays the break animation, sets fade value and blockDead
	anim.play("block-" + str(blockValue) + "-die")
	fade = 0.5
	blockDead = true

func set_animation(chosen):
	#Stores sprite number and play the base animation
	blockValue = chosen
	anim.play("block-" + str(chosen) + "-idle")
	
