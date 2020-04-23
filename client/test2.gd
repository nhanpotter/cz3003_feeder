extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


#Hardcoded data to test battle:
var self_stats = {"HP":100, "Attack":5, "Level":5, "Gold":25}
var enemy_stats = {"id":1, "HP":50, "Attack":5, "qbank_id": 1}
var timer = 5 #seconds per question
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(params):
	print("Hello World")
	print(params)

func _on_Button_pressed():
	var next_scene = Scene_Manager.get_scene_path("test")
	print(next_scene)
	var myString = "called from test 2"
	Scene_Manager.goto_scene(next_scene,myString)
	pass

func _on_Button2_pressed():
	Scene_Manager.singleton_test +=1
	print(Scene_Manager.singleton_test)
	pass

func _on_Button3_pressed():
	var params = {"self":self_stats,"enemy":enemy_stats,"timer":timer}
	Battle_Manager.init_battle(params)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
