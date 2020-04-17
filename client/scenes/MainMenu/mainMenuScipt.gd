extends Node2D
var x

#variables to initialise according to userID
#char stats to be initialised
var user_stats = {}
var charLevel = 0
var charExp = 0
var charGold = 0
var charHp = 100
var charAtt = 8
var charGender = "M"

var init_flag = false

# Called when the node enters the scene tree for the first time.
func _ready():
	while init_flag == false:
		pass
	_set_sprite()
	_set_player_stats()
	

	pass # Replace with function body.
	
func init(params):
	print("main menu initializing...")#debug
	
	user_stats = Common_Services.get_user_stats()
	charLevel = user_stats["level"]
	charExp = user_stats["experience"]
	charGold = user_stats["gold"]
	charHp = user_stats["hp"]
	charAtt = user_stats["attack"]
	if user_stats["gender"] == 1:
		charGender = "M"
	else:
		charGender = "F"

	init_flag = true

func _set_sprite():
	var spriteid = Common_Services.get_spriteId(charLevel,charGender)
	#set display texture box according to user account info
	var sprite = Common_Services.get_sprite(spriteid)
	$Character/charDisplay.set_texture(sprite)

func _set_player_stats():
	$CharStatsInfo1/LevelValue.set_text(str(charLevel)) 
	$CharStatsInfo1/ExpValue.set_text(str(charExp))
	$CharStatsInfo1/GoldValue.set_text(str(charGold))
	$CharStatsInfo2/HpValue.set_text(str(charHp))
	$CharStatsInfo2/AttValue.set_text(str(charAtt))

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Clan_pressed():
	var path = Scene_Manager.get_scene_path("clan")
	var params = {}
	Scene_Manager.goto_scene(path, params)
	pass # Replace with function body.


func _on_Logout_pressed():
	$logoutConfirm.popup_centered()
	
	pass # Replace with function body.

func handle_logout(result,response_code,headers,body):
	print("logout successful")
	
	var path = Scene_Manager.get_scene_path("login")
	var params = {}
	Scene_Manager.goto_scene(path,params)

func _on_FightTest_pressed():
	pass # Replace with function body.


func _on_Expedition_pressed():
	var path = Scene_Manager.get_scene_path("lobby")
	var params = Expedition_Lobby_Manager.get_expeditions()
	Scene_Manager.goto_scene(path, params)
	pass # Replace with function body.




func _on_Custom_pressed():
	var path = Scene_Manager.get_scene_path("test")
	Scene_Manager.goto_scene(path,0)
	pass # Replace with function body.


func _on_Settings_pressed():
	x = get_tree().change_scene("res://Scenes/settingsScene/settingsScene.tscn")
	pass # Replace with function body.


func _on_Leaderboard_pressed():
	Network_Services.get_leaderboard(self,"on_receive_leaderboard")

	pass # Replace with function body.

func on_receive_leaderboard(result,response_code,headers,body):
	var json = JSON.parse(body.get_string_from_utf8())
	print("leaderboard entries are...") #debug
	print(json.result) #debug
	var params = json.result
	var path = Scene_Manager.get_scene_path("leaderboard")
	Scene_Manager.goto_scene(path,params)


func _on_Question_pressed():

	pass # Replace with function body.


func _on_MapTest_pressed():

	pass # Replace with function body.


func _on_logoutConfirm_confirmed():
	Network_Services.logout(self,"handle_logout")
	
	pass # Replace with function body.
