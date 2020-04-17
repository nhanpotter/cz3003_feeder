extends Node

var http_flag = false
var player = {} 
var enemy = {}

#hardcoded questionbank data for testing
var q1 = {"question" : "1 + 1 = ?", "a1" : "1", "a2" : "2", "a3" : "3", "a4" : "4","answer":"2"}
var q2 = {"question" : "2 + 2 = ?", "a1" : "2", "a2" : "4", "a3" : "6", "a4" : "8","answer":"4"}
var q3 = {"question" : "3 + 3 = ?", "a1" : "3", "a2" : "6", "a3" : "9", "a4" : "12","answer":"6"}
var q4 = {"question" : "4 + 4 = ?", "a1" : "4", "a2" : "8", "a3" : "12", "a4" : "16","answer":"8"}
var QuestionBank = [q1,q2,q3,q4]

var battle_instance
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#starts a new battle
func init_battle(caller,npc_ref):
	count = count+1
	var scene_path = Scene_Manager.get_scene_path("battle")
	player = Common_Services.get_user_stats()
	var resource = load(scene_path)
	battle_instance = resource.instance()
	battle_instance.init(count)
	battle_instance.get_npc_reference(npc_ref)
	caller.add_child(battle_instance)
	pass	

func delete_battle():
	print("deleting...")#debug
	battle_instance.queue_free()

func set_question_bank(q_bank):
	QuestionBank = q_bank
	pass	

func set_self_stats():
	player = Common_Services.get_user_stats()

func set_enemy(stats):
	enemy = stats


#returns self data such as stats etc
func get_self_stats():
	return player

#returns enemy data such as sprite, stats etc	
func get_enemy_stats():
	return enemy

#returns the question bank attached to the enemy
func get_question_bank():
	return QuestionBank

#called when a battle is over
func resolve_battle(outcome):
	if outcome == "win":
		print("You Won!!")
	elif outcome == "lose":
		print("You lost :(")
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
