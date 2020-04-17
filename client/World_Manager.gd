extends Node
var temp_background_type
var temp_world_id
var temp_is_finished
# Called when the node enters the scene tree for the first time.
func _ready():
	print("World manager loaded!") #debug
	pass # Replace with function body.


func init_world(world):
	temp_background_type = world["background_type"]
	temp_world_id = world["id"]
	temp_is_finished = world["is_finished"]

	print("This world id is : " + str(temp_world_id)) #debug
	print("This world is of background type : " + str(temp_world_id))
	print("This world's finished status is : "+str(temp_is_finished))
	Network_Services.get_world(self,"on_world_received",temp_world_id)



func on_world_received(result,response_code,headers,body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(result)
	print(json.result)
	if json.result == null:
		print("error! null data received") #debug
	else:
		var params = json.result
		var path = Scene_Manager.get_scene_path("world")
		params.append(temp_background_type)
		Scene_Manager.goto_scene(path,params)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
