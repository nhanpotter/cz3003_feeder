extends Node2D

var inputid = null
var inputpw = null
onready var animation = preload("res://scenes/loading/Loading.tscn")
onready var animation_instance = animation.instance()


var auth_flag = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(params):
	pass




func _on_Login_pressed():
	print(inputid + " " + inputpw)
	Network_Services.login(self,"handle_login",inputid,inputpw)
	self.add_child(animation_instance)

func handle_login(result, response_code, headers, body):
	
	var json = JSON.parse(body.get_string_from_utf8())
	Login_Manager.lobby_flag = false
	Login_Manager.user_stats_flag = false
	print(json.result)
	print(response_code)
	auth_flag = true

	if json.result.has('auth_token') == true:
		_on_successful_login()


	else :
		print("error!login unsuccessful")
		self.remove_child(animation_instance)
		var layer = CanvasLayer.new()
		layer.set_layer(2)
		
		var diag = AcceptDialog.new()
		diag.get_label().text = "Unsuccessful Login! Please try again!"
		diag.connect("confirmed",self,"_clean_dialog")
		layer.add_child(diag)
		self.add_child(layer)
		diag.popup_centered()	
	
#handle anything upon successful login, remember to create callback functions to update the flag in login manager
func _on_successful_login():

	
	CheckNConnections.set_init_flag(1)
	Network_Services.get_user_info(self,"handle_first_login")
	print("initializing data...") #debug
	Network_Services.get_lobby(self,"on_lobby_receive")

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

func handle_first_login(result,response_code,headers,body):
	var json = JSON.parse(body.get_string_from_utf8())
	var user_info = json.result
	print("user info is :" + str(user_info))
	#var false_flag = "False"
	#var true_flag = "True"
	if user_info["first_time_login"] == false:
		print("getting avatar info...") #debug
		Network_Services.get_avatar(self,"on_avatar_receive")
		var params = {"inputid": inputid, "inputpw": inputpw}
		Login_Manager.init_main(params)
	elif user_info["first_time_login"] == true:
		var params = 0
		Login_Manager.init_avatar_creation(params)
	


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
