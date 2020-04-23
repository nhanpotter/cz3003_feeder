extends "res://addons/gut/test.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


### Test Functions ###


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# class TestIntegration:
# 	extends "res://addons/gut/test.gd"
signal login_success

var _token = ''

func before_each():
	setup_login()

func setup_login():
	Network_Services.login(self, "handle_login", "feeder", "dummy123")

func handle_login(result,response_code,headers,body):
	assert_eq(response_code, 200, "Login Successful")
	var json = JSON.parse(body.get_string_from_utf8())
	_token = json.result.auth_token
	emit_signal("login_success")


func test_integration_common_and_network():
	"""
	Test Integration between Common and Network Subsystems
	"""
	yield(self, 'login_success')
	Network_Services.token = _token

	Common_Services.test_get_avatar_info()
	yield(Common_Services, 'get_avatar_success')

	assert_not_null(Common_Services.get_user_stats(), 
		"Check integration between CommonServices and Network_Services")
	

func test_integration_expedition_world_and_network():
	"""
	Test Integration between Expedition and Network Subsystems
	"""
	yield(self, 'login_success')
	Network_Services.token = _token

	Expedition_Lobby_Manager.test_request_expedition_list()
	yield(Expedition_Lobby_Manager, 'get_lobby_success')

	assert_ne(len(Expedition_Lobby_Manager.expedition_list), 0, 
		"Check integration between Expedition_Lobby_Manager and Network_Services")
		
	var first_expedition = Expedition_Lobby_Manager.expedition_list[0]
	Expedition_Manager.test_request_worlds(first_expedition.id)
	yield(Expedition_Manager, 'get_expedition_success')
#
	assert_ne(len(Expedition_Manager.worlds), 0, 
		"Check integration between Expedition Lobby and Network_Services")

	var first_world = Expedition_Manager.worlds[0]
	World_Manager.test_init_world(first_world)
	yield(World_Manager, 'get_world_success')

	assert_not_null(World_Manager.test_result, 
		"Check Integration between World_Manager and Network_Services")
	

func test_integration_expeditition_common_and_network():
	"""
	Test Integration between Common and Network Subsystems
	"""
	yield(self, 'login_success')
	Network_Services.token = _token

	Common_Services.test_get_avatar_info()
	yield(Common_Services, 'get_avatar_success')

	assert_not_null(Common_Services.get_user_stats(), 
		"Check integration between CommonServices and Network_Services")

	Battle_Manager.test_init_battle()

	assert_ne(Battle_Manager.get_self_stats(), {},
		"Check integration between CommonServices and Network_Services")
			
