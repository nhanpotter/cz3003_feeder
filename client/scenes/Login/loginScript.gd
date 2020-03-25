extends Node2D

var inputid = null
var inputpw = null

#test id and pw
var id = "test"
var pw = "123"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(params):
	pass

func _on_Login_pressed():
	#add login manager
	var params = {"inputid": inputid, "inputpw": inputpw}
	if true:
		Login_Manager.init_main(params)
	else:
		$LoginFail.popup_centered()
	#pass # Replace with function body.


func _on_Login2_pressed():
	var main = Scene_Manager.get_scene_path("mainmenu")
	var params = {}
	Scene_Manager.goto_scene(main, params)
	pass # Replace with function body.


func _on_inputid_text_changed(new_text):
	inputid = new_text
	pass # Replace with function body.S


func _on_inputpw_text_changed(new_text):
	inputpw = new_text
	pass # Replace with function body.


func _on_Signup_pressed():
	var params = {}
	Login_Manager.init_signup(params)
	pass # Replace with function body.
