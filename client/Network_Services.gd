extends HTTPRequest


# Declare member variables here. Examples:
const GET_REQUEST = 0
const POST_REQUEST = 1
var base_url = "http://172.21.148.177:7000/"
var token = ""
var result = ''
signal request_finished
# Called when the node enters the scene tree for the first time.
func _ready():
	check_connection()
	

#checks connection periodically,taken from checkNconnections
func check_connection():
	CheckNConnections.connect("connection_success", self, "_on_success")
	CheckNConnections.connect("error_connection_failed", self, "_on_failure")
	CheckNConnections.connect("error_ssl_handshake", self, "_on_fail_ssl_handshake")
	pass 

#handling functions on connection error
func _on_success():
	#hide this if you do not wish to test and the print messages are annoying
	#print("Connection Success!!")
	pass
	
func _on_failure(code, message):
	print("Connection Failure!!\nCode: ", code, " Message: ", message)
	
func _on_fail_ssl_handshake():
	print("SSL Handshake Error!!")
	
func _on_handle_login(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var auth_token = json.result.auth_token
	token = auth_token

func _on_handle_logout(result, response_code, headers, body):
	token = ""
	
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
	var headers = ["Content-Type: application/json"]
	if token:
		var auth_token = "Authorization: Token {token}".format({"token": token})
		headers.append(auth_token)
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
		
	# Log Error
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	elif error == ERR_CANT_CONNECT:
		push_error("An error occured in the HTTP request.")
		
	return http_node
	
################ API Endpoints ####################################
### Instruction 
# caller(Node): the node that ask for request (just put 'self'')
# callback(String): put the String of your callbank function name
###
func login(caller, callback, username, password):
	var url = "auth/token/login/"
	var body_data = {
		"username": username,
		"password": password,
	}
	var http_node = _request_server(caller, url, callback, POST_REQUEST, body_data)
	http_node.connect("request_completed", self, "_on_handle_login")


func logout(caller, callback):
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
	var url = "auth/users/me/"
	_request_server(caller, url, callback)


func create_avatar(caller, callback, gender):
	var url = "account/avatar/"
	var body_data = {
		"gender": gender
	}
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

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
