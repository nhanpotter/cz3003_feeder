extends HTTPRequest


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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
	
#general function to get data from server
func get_from_server(caller,url):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", caller, "_http_request_completed")
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	elif error == ERR_CANT_CONNECT:
		push_error("An error occured in the HTTP request.")


	
func _http_request_completed( result, response_code, headers, body ):

	var json = JSON.parse(body.get_string_from_utf8())

	#print(json.result)
	
	
	
	

#general function to update server
func send_to_server():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
