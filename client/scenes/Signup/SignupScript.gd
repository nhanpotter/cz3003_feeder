extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x; #to prevent screen error only
var inputId;
var inputPw;
var confirmPw;
var inputEmail;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(params):
	pass

func _on_idinput_text_changed(new_text):
	inputId = new_text;
	pass # Replace with function body.


func _on_pwinput_text_changed(new_text):
	inputPw = new_text;
	pass # Replace with function body.

func _on_confirmPassword_text_changed(new_text):
	confirmPw = new_text;
	pass # Replace with function body.

func _on_emailinput_text_changed(new_text):
	inputEmail = new_text;
	pass # Replace with function body.


#post request to server 
func _on_SignupButton_pressed():
	#post inputId, inputPw, inputEmail;
	if inputPw != confirmPw:
		$pwError.popup_centered();
	else:
		#post request
		
		$signupSuccess.popup_centered()
		
	pass # Replace with function body.




func _on_ToolButton_pressed():
	
	pass # Replace with function body.


func _on_signupSuccess_confirmed():
	var scenepath = Scene_Manager.get_scene_path("login")
	var params = {}
	Scene_Manager.goto_scene(scenepath, params)
	pass # Replace with function body.
