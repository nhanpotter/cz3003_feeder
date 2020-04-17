extends Node


var worlds = []
var request_flag = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# function to prepare the expedition upon button click in lobby	
func init_expedition(expedition_id):
	_request_worlds(expedition_id)
	print("waiting for data...") #debug
	complete_expedition_request()

	

func complete_expedition_request():
	
	yield()
	print("initializing expedition map...") #debug
	var path = Scene_Manager.get_scene_path("expedition")
	Scene_Manager.goto_scene(path,worlds)


func _request_worlds(expedition_id):
	print(expedition_id) #debug
	Network_Services.get_expedition(self,"handle_worlds_request",expedition_id)

func handle_worlds_request(result,response_code,headers,body):
	var y = complete_expedition_request()
	var json = JSON.parse(body.get_string_from_utf8())
	print("received data : " + str(json.result)) #debug
	worlds = json.result
	y.resume()
	request_flag = true
	

	 



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
