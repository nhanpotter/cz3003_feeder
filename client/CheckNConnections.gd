
extends HTTPRequest

signal connection_success
signal error_connection_failed(code, message)
signal error_ssl_handshake

var check_timer = null
var request_counter = 0
var requests_complete_counter = 0

func _ready():
	
	check_timer = Timer.new()
	check_timer.autostart = true
	check_timer.one_shot = false
	check_timer.wait_time = 3
	check_timer.connect("timeout", self, "_check_connection")
	add_child(check_timer)
	connect("request_completed", self, "on_request_result")

func stop_check():
	if not check_timer.is_stopped():
		check_timer.stop()

func start_check():
	if check_timer.is_stopped():
		check_timer.start()

func _check_connection():
	if request_counter == requests_complete_counter:
		request_counter += 1
		request("http://172.21.148.177:7000/blabla") # This address is only for test. You need to change your trusted and believing return success address...
	else:
		push_error("Server response timed out!")
		print("Server response timed out!")
		# TODO : handle server time out
func on_request_result(result, response_code, headers, body):
	match result:
		RESULT_SUCCESS:
			emit_signal("connection_success")
			requests_complete_counter +=1
		RESULT_CHUNKED_BODY_SIZE_MISMATCH:
			emit_signal("error_connection_failed", RESULT_CHUNKED_BODY_SIZE_MISMATCH, "RESULT_CHUNKED_BODY_SIZE_MISMATCH")
			requests_complete_counter +=1
		RESULT_CANT_CONNECT:
			emit_signal("error_connection_failed", RESULT_CANT_CONNECT, "RESULT_CANT_CONNECT")
			requests_complete_counter +=1
		RESULT_CANT_RESOLVE:
			emit_signal("error_connection_failed", RESULT_CANT_RESOLVE, "RESULT_CANT_RESOLVE")
			requests_complete_counter +=1
		RESULT_CONNECTION_ERROR:
			emit_signal("error_connection_failed", RESULT_CONNECTION_ERROR, "RESULT_CONNECTION_ERROR")
			requests_complete_counter +=1
		RESULT_SSL_HANDSHAKE_ERROR:
			emit_signal("error_ssl_handshake")
			requests_complete_counter +=1
		RESULT_NO_RESPONSE:
			emit_signal("error_connection_failed", RESULT_NO_RESPONSE, "RESULT_NO_RESPONSE")
			requests_complete_counter +=1
		RESULT_BODY_SIZE_LIMIT_EXCEEDED:
			emit_signal("error_connection_failed", RESULT_BODY_SIZE_LIMIT_EXCEEDED, "RESULT_BODY_SIZE_LIMIT_EXCEEDED")
			requests_complete_counter +=1
		RESULT_REQUEST_FAILED:
			emit_signal("error_connection_failed", RESULT_REQUEST_FAILED, "RESULT_REQUEST_FAILED")
			requests_complete_counter +=1
		RESULT_DOWNLOAD_FILE_CANT_OPEN:
			emit_signal("error_connection_failed", RESULT_DOWNLOAD_FILE_CANT_OPEN, "RESULT_DOWNLOAD_FILE_CANT_OPEN")
			requests_complete_counter +=1
		RESULT_DOWNLOAD_FILE_WRITE_ERROR:
			emit_signal("error_connection_failed", RESULT_DOWNLOAD_FILE_WRITE_ERROR, "RESULT_DOWNLOAD_FILE_WRITE_ERROR")
			requests_complete_counter +=1
		RESULT_REDIRECT_LIMIT_REACHED:
			emit_signal("error_connection_failed", RESULT_REDIRECT_LIMIT_REACHED, "RESULT_REDIRECT_LIMIT_REACHED")
			requests_complete_counter +=1
