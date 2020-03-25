extends Node



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Main Loaded")
	load_first_scene()
	pass


# function to load the first scene on startup, usually the login page	
func load_first_scene():
	var first_scene = Scene_Manager.get_scene_path(1)
	print(first_scene)
	get_tree().change_scene(first_scene)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
