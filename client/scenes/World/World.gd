extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var flag = false
var params = 0
var background = preload("res://expedition_assets/background1.tscn")
var npc = preload("res://expedition_assets/npc.tscn")
var player = preload("res://expedition_assets/Player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	#init(0)
	pass
	
	
	

func init(params):
	
	var bg = background.instance()
	var np = npc.instance()
	var py = player.instance()
	add_child(bg)
	add_child(np)
	add_child(py)
	
	#var npc_object = get_node(np)
	#print(npc_object.get_position_in_parent())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


	
