extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation = preload("res://scenes/loading/Loading.tscn")
onready var animation_instance = animation.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(params):
	pass

func _on_Male_pressed():
	create_avatar(1)

	pass

func _on_Female_pressed():
	create_avatar(2)
	
	pass

func create_avatar(gender):
	Network_Services.create_avatar(self,"handle_avatar_creation",gender)
	var position = Vector2(510,150)
	animation_instance.get_node("Sprite").set_global_position(position)
	self.add_child(animation_instance)

func handle_avatar_creation(result,response_code,headers,body):
	print("Avatar successfully created!")
	Network_Services.get_lobby(self,"on_lobby_receive")
	Network_Services.get_avatar(self,"on_avatar_receive")
	Login_Manager.init_main(0) 

func on_lobby_receive(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
		
	for expedition in json.result:
		Expedition_Lobby_Manager.expedition_list.append(expedition)
	print(Expedition_Lobby_Manager.expedition_list)	
	Login_Manager.lobby_flag = true
	pass

func on_avatar_receive(result,response_code,headers,body):
	var json = JSON.parse(body.get_string_from_utf8())
	print("avatar info is : "+str(json.result))
	Common_Services.set_user_stats(json.result)
	Login_Manager.user_stats_flag = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
