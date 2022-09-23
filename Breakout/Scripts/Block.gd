extends AnimatedSprite

export var hp = 1
onready var anim = self

func remove():
	#play break animation
	self.queue_free()

func _on_Up_area_entered(area):
	if (area.name == "Ball"):
		area.velocity.y = -abs(area.velocity.y)
		hp -= hp
		if hp == 0:
			remove()

func _on_Down_area_entered(area):
	if (area.name == "Ball"):
		area.velocity.y = abs(area.velocity.y) 
		hp -= hp
		if hp == 0:
			remove()
		
func _on_Left_area_entered(area):
	if (area.name == "Ball"):
		area.velocity.x = -abs(area.velocity.x)
		hp -= hp
		if hp == 0:
			
			remove()
		
func _on_Right_area_entered(area):
	if (area.name == "Ball"):
		area.velocity.x = abs(area.velocity.x)
		hp -= hp
		if hp == 0:
			remove()

func set_animation(chosen):
	print(chosen)
	anim.play("block-" + str(chosen) + "-idle")
	
