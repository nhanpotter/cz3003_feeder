extends Node

#var params = {"loginid": null, "loginpw": null}
var loginid = null
var loginpw = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init_main(params):
	var scene_path = Scene_Manager.get_scene_path("mainmenu")
	
	#service to check login credentials
	Scene_Manager.goto_scene(scene_path,params)
	pass
	
func init_signup(params):
	print("siggggg")
	var scene_path = Scene_Manager.get_scene_path("signup")
	Scene_Manager.goto_scene(scene_path,params)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
