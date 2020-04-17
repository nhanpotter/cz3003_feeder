extends Node

#these variables updated via loginScript, to control entering main menu after getting the required data from server
var lobby_flag = false
var user_stats_flag = false
#var params = {"loginid": null, "loginpw": null}
var loginid = null
var loginpw = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init_main(params):

	while (lobby_flag == false) || (user_stats_flag == false):
		yield(get_tree().create_timer(2.0), "timeout")
		print("loading main menu...") #debug

	var scene_path = Scene_Manager.get_scene_path("mainmenu")
	Scene_Manager.goto_scene(scene_path,params)
	pass
	
func init_signup(params):
	var scene_path = Scene_Manager.get_scene_path("signup")
	Scene_Manager.goto_scene(scene_path,params)

func init_avatar_creation(params):
	var scene_path = Scene_Manager.get_scene_path("avatar")
	Scene_Manager.goto_scene(scene_path,params)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
