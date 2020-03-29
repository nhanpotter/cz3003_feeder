extends Node

const levelmin	= 0
const levellower = 3
const levelupper = 7
const levelmax = 10



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
#load sprite assets
func get_sprite(spriteId):
	var path = "res://common_assets/Character/" + spriteId + ".png"
	var sprite = load(path)
	return sprite
	pass

func get_spriteId(charLevel, charGender):
	if charGender == "F":
		if charLevel in range(levelmin,levellower):
			return "F1"
		elif charLevel in range(levellower,levelupper):
			return "F2"
		else:
			return "F3"
	elif charGender == "M":
		if charLevel in range(levelmin,levellower):
			return "M1"
		elif charLevel in range(levellower,levelupper):
			return "M2"
		else:
			return "M3"
