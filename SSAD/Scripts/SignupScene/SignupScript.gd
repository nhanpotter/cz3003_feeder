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
		_on_pwError_about_to_show();
	x = get_tree().change_scene("res://Scenes/loginScene/loginScene.tscn");
	pass # Replace with function body.




func _on_ToolButton_pressed():
	
	pass # Replace with function body.


func _on_pwError_about_to_show():
	
	pass # Replace with function body.
