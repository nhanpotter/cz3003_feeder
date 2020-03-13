extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var username = 'feeder'
var password = 'dummy123'
var API_URL = 'http://172.21.148.177:7000/'
var token

func _make_post_request(http_node, url, data_to_send, headers, use_ssl):
	var query = JSON.print(data_to_send)
	
	http_node.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)

func _make_get_request(http_node, url, headers):
	http_node.request(url, headers)


func _on_Button_pressed():
	"""
	This function is for login
	Send a post request to server using username and password
	"""
	var url = API_URL + 'auth/token/login'
	var data_to_send = {'username': username, 'password': password}
	var headers = ["Content-Type: application/json"]
	
	_make_post_request($HTTPRequest, url, data_to_send, headers, false)
	

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	token = 'Token ' + json.result.auth_token
	print(json.result.auth_token)


func _on_Button2_pressed():
	"""
	This function is to get user's info
	Send a get request to server with a custom 'Authorization' header
	Authorization header format: 'Authorization: Token f8ef08b27961146cb471ff4e2097683979173224'
	"""
	var url = API_URL + 'auth/users/me'
	var headers = ["Content-Type: application/json", 'Authorization: {token}'.format({'token': token})]
	_make_get_request($HTTPRequest2, url, headers)
	


func _on_HTTPRequest2_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
