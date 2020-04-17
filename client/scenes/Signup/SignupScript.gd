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
	
	if inputPw != confirmPw:
		$pwError.popup_centered();
	else:
		#post request
		Network_Services.sign_up(self,"handle_signup",inputId,inputEmail,inputPw,confirmPw)
		$signupSuccess.popup_centered()
		
	pass # Replace with function body.

func handle_signup(result,response_code,headers,body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)



func _on_ToolButton_pressed():
	
	pass # Replace with function body.


func _on_signupSuccess_confirmed():
	var scenepath = Scene_Manager.get_scene_path("login")
	var params = {}
	Scene_Manager.goto_scene(scenepath, params)
	pass # Replace with function body.
