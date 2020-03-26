extends Node2D
var x

#variables to initialise according to userID
#char stats to be initialised
var charLevel = 2
var charExp = 9
var charGold = 55
var charHp = 100
var charAtt = 8
var charGender = "M"

# Called when the node enters the scene tree for the first time.
func _ready():
	var spriteid = Common_Services.get_spriteId(charLevel,charGender)
	#set display texture box according to user account info
	var sprite = Common_Services.get_sprite(spriteid)
	$Character/charDisplay.set_texture(sprite)
	
	
	$CharStatsInfo1/LevelValue.set_text(str(charLevel)) 
	$CharStatsInfo1/ExpValue.set_text(str(charExp))
	$CharStatsInfo1/GoldValue.set_text(str(charGold))
	$CharStatsInfo2/HpValue.set_text(str(charHp))
	$CharStatsInfo2/AttValue.set_text(str(charAtt))
	pass # Replace with function body.
	
func init(params):
	pass


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
	#x = get_tree().change_scene("res://Scenes/loginScene/loginScene.tscn")
	pass # Replace with function body.


func _on_FightTest_pressed():
	x = get_tree().change_scene("res://Scenes/fightTestScene/Battle.tscn")
	pass # Replace with function body.


func _on_Expedition_pressed():
	var path = Scene_Manager.get_scene_path("levelMap")
	var textList = LevelMapMenu_Manager.getTextList("some userdata")
	Scene_Manager.goto_scene(path, textList)
	pass # Replace with function body.




func _on_Custom_pressed():
	x = get_tree().change_scene("res://Scenes/customScene/customScene.tscn")
	pass # Replace with function body.


func _on_Settings_pressed():
	x = get_tree().change_scene("res://Scenes/settingsScene/settingsScene.tscn")
	pass # Replace with function body.


func _on_Shop_pressed():
	x = get_tree().change_scene("res://Scenes/shopScene/shopScene.tscn")
	pass # Replace with function body.


func _on_Question_pressed():
	x = get_tree().change_scene("res://Scenes/questionScene/questionScene.tscn")
	pass # Replace with function body.


func _on_MapTest_pressed():
	x = get_tree().change_scene("res://Scenes/expeditionScene/World Select/lobby/main_lobby.tscn")
	pass # Replace with function body.


func _on_logoutConfirm_confirmed():
	var path = Scene_Manager.get_scene_path("login")
	var params = {}
	Scene_Manager.goto_scene(path,params)
	pass # Replace with function body.
