extends Panel

const ListItem = preload("res://scenes/MapScene/Panel.tscn")

#get from database the modules
#var textList = ["MODULE A", "MODULE B", "MODULE C", "MODULE D","A","A","A","A","A","A","A","A"]
var textList

#get from database the scene file names
#var sceneList = ["MODULE_A.tscn", "MODULE_B.tscn", "MODULE_C.tscn", "MODULE_D.tscn"]


func addItem():
	for row in textList:
		var item = ListItem.instance()
		item.get_node("Button").text = row
		item.get_node("Button").name = row
		item.rect_min_size = Vector2(320,55)
		$ScrollContainer/List.add_child(item)
		


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	addItem()
	
	
func _physics_process(delta: float) -> void:
	pass

	
func set_textList(param):
	textList = param
	print(textList)
	
func init(params):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
