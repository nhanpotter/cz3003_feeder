extends HTTPRequest


# Declare member variables here. Examples:
const GET_REQUEST = 0
const POST_REQUEST = 1
var base_url = "https://coderquest-server.herokuapp.com/"
var token = ""
var result = ''
signal request_finished
onready var layer = CanvasLayer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	check_connection()
	

#checks connection periodically,taken from checkNconnections
func check_connection():
	CheckNConnections.connect("connection_success", self, "_on_success")
	CheckNConnections.connect("error_connection_failed", self, "_on_failure")
	CheckNConnections.connect("error_ssl_handshake", self, "_on_fail_ssl_handshake")
	CheckNConnections.connect("connection_timed_out",self,"_on_failure")
	pass 

#handling functions on connection error
func _on_success():
	#hide this if you do not wish to test and the print messages are annoying
	#print("Connection Success!!") #debug
	
	
	
	pass
	
func _on_failure(code, message):
	layer.queue_free()
	print("Connection Failure!!\nCode: ", code, " Message: ", message)
	layer = CanvasLayer.new()
	layer.set_layer(2)
	
	var diag = AcceptDialog.new()
	diag.get_label().text = "CONNECTION LOST, PLEASE CHECK CONNECTION"
	layer.add_child(diag)
	self.add_child(layer)
	diag.popup_centered()
	
	
func _on_fail_ssl_handshake():
	print("SSL Handshake Error!!")
	
func _on_handle_login(result, response_code, headers, body):
	print("_on_handle_login Network_Services") #debug
	var body_string = body.get_string_from_utf8()
	var success = handle_result_from_request(result, body_string)
	if not success:
		return

	var json = JSON.parse(body_string)
	if response_code == 200:
		var auth_token = json.result.auth_token
		token = auth_token
	else:
		# Error Handling
		pass

func _on_handle_logout(result, response_code, headers, body):
	print("logged out successfully")
	var body_string = body.get_string_from_utf8()
	var success = handle_result_from_request(result, body_string)
	if not success:
		return

	if response_code == 204:
		token = ""
	else:
		# Error Handling
		pass
	
###############
# Util
func add_base_url(url):
	return base_url + url
	
func is_logged_in():
	if token:
		return true
	return false

################
# Request Util
func _make_get_request(http_node, url, headers):
	http_node.request(url, headers)
	
func _make_post_request(http_node, url, data_to_send, headers, use_ssl):
	var query = JSON.print(data_to_send)
	
	http_node.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)

func _prepare_headers():
	#print("preparing headers...") #debug
	var headers = ["Content-Type: application/json"]
	if token:
		var auth_token = "Authorization: Token {token}".format({"token": token})


		headers.append(auth_token)
	#print("headers is :" + str(headers)) #debug	
	return headers

func _request_server(caller, url, callback, request_type=GET_REQUEST, body_data=null):
	url = add_base_url(url)
	var headers = _prepare_headers()
	var http_node = caller.find_node(callback, false, false);
	if not http_node:
		http_node = HTTPRequest.new()
		caller.add_child(http_node)
		# Set name and owner for node finding
		http_node.name = callback
		http_node.owner = caller
		http_node.connect("request_completed", caller, callback)
		
	var error;
	if request_type == GET_REQUEST:
		error = _make_get_request(http_node, url, headers)
	elif request_type == POST_REQUEST:
		
		error = _make_post_request(http_node, url, body_data, headers, false)
		
		

		
	return http_node

func handle_result_from_request(result, body_string):
	if result == RESULT_SUCCESS:
		return true
	else:
		layer = CanvasLayer.new()
		layer.set_layer(2)

		var diag = AcceptDialog.new()
		diag.get_label().text = body_string
		layer.add_child(diag)
		self.add_child(layer)
		diag.popup_centered()

		return false
	
################ API Endpoints ####################################
### Instruction 
# caller(Node): the node that ask for request (just put 'self'')
# callback(String): put the String of your callbank function name
# callback function format : myFunc(result,response_code,headers,body)
###
func login(caller, callback, username, password):
	print("attemping to log in...") #debug
	var url = "auth/token/login/"
	var body_data = {
		"username": username,
		"password": password,
	}
	
	var http_node = _request_server(caller, url, callback, POST_REQUEST, body_data)
	
	http_node.connect("request_completed", self, "_on_handle_login")


func logout(caller, callback):
	print("logging out...") #debug
	var url = "auth/token/logout"
	var http_node = _request_server(caller, url, callback, POST_REQUEST, null)
	http_node.connect("request_completed", self, "_on_handle_logout")

func sign_up(caller, callback, username, email, password, re_password):
	var url = "auth/users/"
	var body_data = {
		"username": username,
		"email": email,
		"password": password,
		"re_password": re_password,
	}
	var http_node = _request_server(caller, url, callback, POST_REQUEST, body_data)


func get_connection_data(caller, callback):
	var url = "testing/"
	_request_server(caller, url, callback)
	
	
func get_user_info(caller, callback):
	print("getting user info...") #debug
	var url = "auth/users/me/"
	_request_server(caller, url, callback)


func create_avatar(caller, callback, gender):
	var url = "account/avatar/"
	var body_data = {
		"gender": gender
	}
	# 1 is male
	# 2 is female
	_request_server(caller, url, callback, POST_REQUEST, body_data)


func get_avatar(caller, callback):
	var url = "account/avatar/"
	_request_server(caller, url, callback)
	

func get_lobby(caller, callback):
	"""Return List of Expedition
	"""
	var url = "game/expedition/"
	_request_server(caller, url, callback)
	
	
func get_expedition(caller, callback, expedition_id):
	print("getting the worlds from expedition...") #debug
	"""Get List of World
	"""
	var url = "game/expedition/{id}/".format({"id": expedition_id})
	_request_server(caller, url, callback)
	
	
func get_world(caller, callback, world_id):
	"""Get List of NPC
	"""
	var url = "game/world/{id}/".format({"id": world_id})
	_request_server(caller, url, callback)
	
	
func get_question_bank_detail(caller, callback, question_bank_id):
	var url = "course/question_bank/detail/{id}/".format({"id": question_bank_id})
	_request_server(caller, url, callback)


func get_npc(caller, callback, npc_id):
	var url = "game/npc/{id}/".format({"id": npc_id})
	_request_server(caller, url, callback)


func defeat_npc(caller, callback, npc_id):
	var url = "game/npc/{id}/defeat/".format({"id": npc_id})
	_request_server(caller, url, callback, POST_REQUEST,null)


func get_leaderboard(caller, callback):
	var url = "account/leaderboard/"
	_request_server(caller, url, callback)


func send_battle_history(caller, callback, list_question):
	var url = "analytics/send_history/"
	var body_data = list_question
	_request_server(caller, url, callback, POST_REQUEST, body_data)

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
