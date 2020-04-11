extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(params):
	print("Hello World")
	print(params)

func _on_Button_pressed():
	var next_scene = Scene_Manager.get_scene_path(2)
	print(next_scene)
	var myString = "called from test"
	Scene_Manager.goto_scene(next_scene,myString)
	pass

func _on_Button2_pressed():
	Scene_Manager.singleton_test +=1
	print(Scene_Manager.singleton_test)
	pass

func _on_Button3_pressed():
	if not Network_Services.is_logged_in():
		Network_Services.login(self, "handle_login", "feeder_temp", "dummy123")
	else:
		Network_Services.logout(self, "handle_logout")
		Network_Services.get_expedition(self, "handle_get_expedition", 1)
	

func handle_login(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)
	
	if response_code == 200:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)
	
func handle_logout(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	
func handle_sign_up(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 201:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)


func handle_get_user_info(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 200:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)


func handle_create_avatar(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 200:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)


func handle_get_avatar(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 200:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)


func handle_get_lobby(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 200:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)


func handle_get_expedition(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 200:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)


func handle_get_world(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 200:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)
	

func handle_get_npc(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 200:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)


func handle_defeat_npc(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 200:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)


func handle_get_question_bank_detail(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 200:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)


func handle_send_battle_history(result, response_code, headers, body):
	var body_string = body.get_string_from_utf8()
	var success = Network_Services.handle_result_from_request(result, body_string)
	if not success:
		return
	
	var json = JSON.parse(body_string)

	if response_code == 201:
		#Handle correct data
		print(json.result)
	else:
		#Handle error
		print(json.result)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
