extends Node2D

### This section for test variables, remove after connecting with other components ###

var user_level = 12
var stages = 0
var worlds = []
var init_flag = false

onready var container = get_node("Container")
onready var container_size = container.get_size()
const map_5_stage = preload("res://scenes/Expedition/ExpeditionMaps/Map_5_stage.tscn")
const map_6_stage = preload("res://scenes/Expedition/ExpeditionMaps/Map_6_stage.tscn")
const map_7_stage = preload("res://scenes/Expedition/ExpeditionMaps/Map_7_stage.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	while init_flag == false:
		pass
	#continue after init
	_prep_stage(stages)


	pass # Replace with function body.
func init(params):
	worlds = params
	var count = 0
	for world in worlds:
		count = count+1
	stages = count
	init_flag = true
	pass

func _prep_stage(stages):
	var map
	if int(stages) <5:
		map = map_5_stage.instance()
	elif int(stages) == 5:
		map = map_5_stage.instance()
	elif int(stages) == 6:
		map = map_6_stage.instance()
	elif int(stages) == 7:
		map = map_7_stage.instance()
	elif int(stages) == 8:
		map = map_5_stage.instance()
	#add more different stages here later


	var template = container.get_node("ColorRect")
	container.remove_child(template)
	var scale = Vector2(0.855,0.700)
	map.set_scale(scale)
	container.add_child(map)

func get_worlds():
	return worlds

func get_user_level():
	#for testing
	return user_level

	#actual implementation
	#Common_Services.get_user_level()


func _clean_dialog():
	pass	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
