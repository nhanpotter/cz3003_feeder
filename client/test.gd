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
	Network_Services.get_from_server(self,"http://www.mocky.iol/v2/5185415ba171ea3a00704eed")
	

func _http_request_completed( result, response_code, headers, body ):
	
	var json = JSON.parse(body.get_string_from_utf8())
		
	print(json.result)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
