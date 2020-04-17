extends Node2D


const Leaderboard_Item = preload("res://scenes/Leaderboard/LeaderboardItem.tscn")
onready var list_left = get_node("BoardLeft/ScrollContainer")
onready var list_right = get_node("BoardRight/ScrollContainer")
var leaderboard_data = []
var init_flag = false

# Called when the node enters the scene tree for the first time.
func _ready():
	while init_flag == false:
		yield(get_tree().create_timer(1.0), "timeout")
	populate_list()
	print("leaderboard loaded!") #debug
	print(leaderboard_data)
	

func init(params):
	leaderboard_data = params.duplicate(true)
	init_flag = true




func populate_list():
	var count = 1
	for entry in leaderboard_data:
		var newEntry = Leaderboard_Item.instance()
		var name = entry["user"]["username"]
		var level = entry["level"]
		var formatted_entry = (str(count)+". "+str(name)+" level : "+str(level))
		newEntry.get_node("Label").set_text(formatted_entry)
		if count <6:
			list_left.get_node("ItemList").add_child(newEntry)
		if count >5 && count<11:
			list_right.get_node("ItemList").add_child(newEntry)
		count = count+1
	pass

func _on_Exit_pressed():
	var path = Scene_Manager.get_scene_path("mainmenu")
	Scene_Manager.goto_scene(path,0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
