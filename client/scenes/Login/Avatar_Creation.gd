extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(params):
	pass

func _on_Male_pressed():
	create_avatar(1)
	Login_Manager.init_main(0)
	pass

func _on_Female_pressed():
	create_avatar(2)
	Login_Manager.init_main(0)
	pass

func create_avatar(gender):
	Network_Services.create_avatar(self,"handle_avatar_creation",gender)

func handle_avatar_creation(result,response_code,headers,body):
	print("Avatar successfully created!") #debug
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
