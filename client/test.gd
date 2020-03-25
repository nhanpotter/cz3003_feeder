extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(params):
	print("Hello World")
	print(params)

func _on_Button_pressed():
	var next_scene = Scene_Manager.get_scene_path(2)
	print(next_scene)
	var myString = "called from test"
	Scene_Manager.goto_scene(next_scene,myString)
	pass

func _on_Button2_pressed():
	Scene_Manager.singleton_test +=1
	print(Scene_Manager.singleton_test)
	pass

func _on_Button3_pressed():
	if Network_Services.is_logged_in():
		Network_Services.get_question_bank_detail(self, "handle_data", 1)
	else:
		Network_Services.login(self, "handle_login", "feeder_temp", "dummy123")
	

func handle_login(result, response_code, headers, body):
	
	var json = JSON.parse(body.get_string_from_utf8())
	
	print(json.result)
	print(response_code)
	
func handle_data(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	
	print(json.result)
	print(response_code)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
