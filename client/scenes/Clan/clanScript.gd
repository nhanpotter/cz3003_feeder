extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(params):
	pass

func _on_Back_pressed():
	var path = Scene_Manager.get_scene_path("mainmenu")
	var params = {}
	Scene_Manager.goto_scene(path,params)
	pass # Replace with function body.
