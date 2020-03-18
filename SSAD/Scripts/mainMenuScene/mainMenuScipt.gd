extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var x


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Clan_pressed():
	x = get_tree().change_scene("res://Scenes/clanScene/clanScene.tscn")
	pass # Replace with function body.


func _on_Logout_pressed():
	x = get_tree().change_scene("res://Scenes/loginScene/loginScene.tscn")
	pass # Replace with function body.


func _on_FightTest_pressed():
	x = get_tree().change_scene("res://Scenes/fightTestScene/Battle.tscn")
	pass # Replace with function body.


func _on_Expedition_pressed():
	x = get_tree().change_scene("res://Scenes/expeditionScene/expeditionScene.tscn")
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
	x = get_tree().change_scene("res://Scenes/expeditionScene/expedition.tscn")
	pass # Replace with function body.
