extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
const btn = preload("res://Scenes/MapScene/green button.tscn")
const label = preload("res://Scenes/MapScene/label.tscn")
var init_flag = false
#get from database completedLevel
var completedLevel
var numOfLevels = 5
var coordinates = [
	 [356.794006, 678.869995],
	 [650.903992, 615.781006],
	 [995.452026, 516.038025],
	 [823.815979, 259.891998],
	 [445.673004, 96.507004]
]

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while init_flag == false:
		pass	
	setCompletedLevel("some userinfo")
	for n in range(completedLevel):
		_setButton(Vector2(coordinates[n][0]-76.249, coordinates[n][1]-90.465))
	for m in range(numOfLevels):
		_setLabel(Vector2(coordinates[m][0], coordinates[m][1]), m+1)

func init(params):
	print("levelMap initializing with params:" +str(params))
	init_flag = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _setButton(position: Vector2) -> void:
	var item = btn.instance()
	#item.get_node("green button").position = position
	item.set_position(position)
	add_child(item)
	
func _setLabel(position: Vector2, num: int):
	var item = label.instance()
	item.position = position
	item.position.y = item.position.y-55
	item.position.x = item.position.x-10
	item.get_node("font").text = str(num)
	add_child(item)

func setCompletedLevel(params):
	completedLevel = LevelMap_Manager.getCompletedLevel(params)
