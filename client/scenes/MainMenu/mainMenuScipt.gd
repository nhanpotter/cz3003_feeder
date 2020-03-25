extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x

#variables to initialise according to userID
var charLevel = 2
var charExp = 9
var charGold = 55
var charHp = 100
var charAtt = 8
var charGender = "F"

#load assets
var F1 = load("res://Assets/Character/F1.png")
var F2 = load("res://Assets/Character/F2.png")
var F3 = load("res://Assets/Character/F3.png")
var M1 = load("res://Assets/Character/M1.png")
var M2 = load("res://Assets/Character/M2.png")
var M3 = load("res://Assets/Character/M3.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if charGender == "F":
		if charLevel in range(0,3):
			$Character/charDisplay.set_texture(F1)
		elif charLevel in range(3,7):
			$Character/charDisplay.set_texture(F2)
		else:
			$Character/charDisplay.set_texture(F3)
	elif charGender == "M":
		if charLevel in range(0,3):
			$Character/charDisplay.set_texture(M1)
		elif charLevel in range(3,7):
			$Character/charDisplay.set_texture(M2)
		else:
			$Character/charDisplay.set_texture(M3)
	
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
	x = get_tree().change_scene("res://Scenes/clanScene/clanScene.tscn")
	pass # Replace with function body.


func _on_Logout_pressed():
	$logoutConfirm.popup_centered()
	#x = get_tree().change_scene("res://Scenes/loginScene/loginScene.tscn")
	pass # Replace with function body.


func _on_FightTest_pressed():
	x = get_tree().change_scene("res://Scenes/fightTestScene/Battle.tscn")
	pass # Replace with function body.


func _on_Expedition_pressed():
	x = get_tree().change_scene("res://Scenes/expeditionScene/World Select/lobby/main_lobby.tscn")
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
