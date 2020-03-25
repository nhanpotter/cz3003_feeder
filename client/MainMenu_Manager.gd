extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init_mainmenu(params):
	var charGender = params.charGender
	
	pass
	

#func get_display_avatar():
#	if charGender == "F":
#		if charLevel in range(0,3):
#			$Character/charDisplay.set_texture(F1)
#		elif charLevel in range(3,7):
#			$Character/charDisplay.set_texture(F2)
#		else:
#			$Character/charDisplay.set_texture(F3)
#	elif charGender == "M":
#		if charLevel in range(0,3):
#			$Character/charDisplay.set_texture(M1)
#		elif charLevel in range(3,7):
#			$Character/charDisplay.set_texture(M2)
#		else:
#			$Character/charDisplay.set_texture(M3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
