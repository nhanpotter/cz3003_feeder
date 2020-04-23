extends Node


var init_flag = false
var expedition_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	print("lobby manager loaded!") #debug

	
	pass
func init_lobby():
	var path = Scene_Manager.get_scene_path("Expedition_Lobby")
	Scene_Manager.goto_scene(path,expedition_list)

func request_expedition_list():
	print("getting expeditions...") #debug
	
	Network_Services.get_lobby(self,"on_lobby_receive")


# receive the lobby information
func on_lobby_receive(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())

	expedition_list.clear()
	for expedition in json.result:
		expedition_list.append(expedition)
	print(expedition_list)	
	pass

func get_expeditions():
	request_expedition_list()
	return 	expedition_list

func clear_expeditions():
	expedition_list.clear()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# For testing
signal get_lobby_success

func test_request_expedition_list():
	print("getting expeditions...") #debug
	
	Network_Services.get_lobby(self,"test_on_lobby_receive")


# receive the lobby information
func test_on_lobby_receive(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())

	expedition_list.clear()
	for expedition in json.result:
		expedition_list.append(expedition)
	print(expedition_list)	
	emit_signal('get_lobby_success')
