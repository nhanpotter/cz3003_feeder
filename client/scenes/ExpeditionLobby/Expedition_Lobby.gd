extends Node2D


const Lobby_Item = preload("res://scenes/ExpeditionLobby/Lobby_Item.tscn")
onready var List = get_node("ColorRect/ScrollContainer")
var Expedition_List = []
var init_flag = false

# Called when the node enters the scene tree for the first time.
func _ready():
	while init_flag == false:
		pass
	populate_list()
	pass # Replace with function body.

#initialize data for expedition lobby
func init(params):
	Expedition_List.clear()
	Expedition_List = params
	init_flag = true
	
	pass

func populate_list():
	print(Expedition_List) #debug
	for item in Expedition_List:
		var newItem = Lobby_Item.instance()
		newItem.get_node("Button").text = item["course"]["course_name"]
		print("my item id is" + str(item["id"]))
		newItem.set_reference_id(str(item["id"]))
		var x = get_node("ColorRect").rect_size.x
		var y = get_node("ColorRect").rect_size.y
		var newSize = Vector2(x,(y/5))
		
		newItem.set_size(newSize)
		print("new item in list is "+str(newItem)) #debug
		List.get_node("ItemList").add_child(newItem)
	


func _on_Exit_pressed():
	var path = Scene_Manager.get_scene_path("mainmenu")
	Scene_Manager.goto_scene(path,0)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
