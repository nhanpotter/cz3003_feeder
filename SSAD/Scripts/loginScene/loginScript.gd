extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x = null #prevent change screen error
var inputid = null
var inputpw = null

#test id and pw
var id = "test"
var pw = "123"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Login_pressed():
	if id == inputid:
		if pw == inputpw:
			x = get_tree().change_scene("res://Scenes/mainMenuScene/mainMenuScene.tscn")
	pass # Replace with function body.


func _on_Login2_pressed():
	x = get_tree().change_scene("res://Scenes/mainMenuScene/mainMenuScene.tscn")
	pass # Replace with function body.


func _on_inputid_text_changed(new_text):
	inputid = new_text
	pass # Replace with function body.S


func _on_inputpw_text_changed(new_text):
	inputpw = new_text
	pass # Replace with function body.


func _on_Signup_pressed():
	x = get_tree().change_scene("res://Scenes/SignupScene/Signup.tscn")
	pass # Replace with function body.
