extends Node


var singleton_test = 0

#variable to track the current active scene displayed
var current_scene = null
var scenes = {"login":"res://scenes/Login/loginScene.tscn",
				"signup":"res://scenes/Signup/Signup.tscn",
				"mainmenu":"res://scenes/MainMenu/mainMenuScene.tscn",
				"battle":"res://scenes/Battle/Battle.tscn",
				"levelMap" : "res://scenes/MapScene/mapScene.tscn",
				"world" : "res://scenes/World/World.tscn"
				}

var previous_scene = null
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Scene Manager loaded")
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)
	
	#get_tree().change_scene(first_scene)


# easy interface to get the path of various scenes used in the project
func get_scene_path(scene_index):
	return scenes[scene_index]	

# public function to switch scenes
func goto_scene(path,params):
	call_deferred("_goto_scene_deferred",path,params)


func goto_previous_scene(params):
	#to go to previous scene, the new path is simply the saved previous scene
	var path = previous_scene
	call_deferred("_goto_scene_deferred",path,params)

# allows the current scene to finish executing its code BEFORE switching scenes
# params are used to set the init of each scene, each scene MUST have init
func _goto_scene_deferred(path,params):
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)
	print(current_scene)
	#after freeing the current scene, it becomes the previous scene
	previous_scene = root.get_child(root.get_child_count()-1)
	#frees the current scene, previous scene is now accurate
	current_scene.free()
	var next_scene_resource = load(path)
	var next_scene = next_scene_resource.instance()
	next_scene.init(params)
	root.add_child(next_scene)
	

	
	
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
