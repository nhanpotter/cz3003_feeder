extends Node

var loginid = {}
var loginpw = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init_main(params):
	var scene_path = Scene_Manager.get_scene_path("mainmenu")
	loginid = params["loginid"]
	loginpw = params["loginpw"]
	Scene_Manager.goto_scene(scene_path,params)
	pass
	
func init_signup(params):
	print("siggggg")
	var scene_path = Scene_Manager.get_scene_path("signup")
	Scene_Manager.goto_scene(scene_path,params)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
