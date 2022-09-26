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

func iframes():
	yield(get_tree().create_timer(0.1), "timeout")
	Global.play_sfx = true

func remove():
	#Runs when animation ends
	#If block is dead (and animation not playing anymore)
	if blockDead:
		self.queue_free()
	else:
		anim.stop()
		set_anim(blockValue)

func _on_Up_area_entered(area):
	if (area.name == "Ball" and !blockDead):
		area.velocity.y = -abs(area.velocity.y)
		iframes()
		blockhp()

func _on_Down_area_entered(area):
	if (area.name == "Ball" and !blockDead):
		area.velocity.y = abs(area.velocity.y) 
		iframes()
		blockhp()
		
func _on_Left_area_entered(area):
	if (area.name == "Ball" and !blockDead):
		area.velocity.x = -abs(area.velocity.x)
		iframes()
		blockhp()
		
func _on_Right_area_entered(area):
	if (area.name == "Ball" and !blockDead):
		area.velocity.x = abs(area.velocity.x)
		iframes()
		blockhp()

func break_animation(blockValue):
	#Plays the break animation, sets fade value and blockDead	
	anim.play("block-" + str(blockValue) + "-die")
	fade = 0.5
	blockDead = true

func set_anim(chosen):
	#Stores sprite number and play the base animation
	blockValue = chosen
	if hp > 1:
		anim.set_animation("block-" + str(blockValue) + "-" + str(hp-1) + "-hit")
		anim.set_frame(0)
	else:
		anim.set_animation("block-" + str(blockValue) + "-die")
		anim.set_frame(0)
	
func blockhp():
	hp -= 1
	if hp == 0:
		if blockValue > 0:
			break_animation(blockValue)
		else: #sprite-0 has no break animation
			blockDead = true
			remove()
	else:
		anim.play("block-" + str(blockValue) + "-" + str(hp) + "-" + "hit")
