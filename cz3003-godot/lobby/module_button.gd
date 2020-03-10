extends Button

export (String) var expedition

# class used to display the button for each module
class ModuleButton extends Button:
	var expedition_to_load
	
	func _ready():
		pass
		
	func _pressed():
		get_tree().change_scene(expedition_to_load)
		
	func _set_expedition(expedition):
		expedition_to_load = expedition
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
	#func _process(delta):
	#	pass
