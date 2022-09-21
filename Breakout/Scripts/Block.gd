extends Sprite


export var hp = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
