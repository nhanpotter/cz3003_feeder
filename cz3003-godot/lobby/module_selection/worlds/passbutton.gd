extends TextureButton

export (bool) var world_passed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _pressed():
	# if level_passed:
		# change world button red -> green
	get_tree().change_scene("res://lobby/module_selection/module1_background.tscn")
		
