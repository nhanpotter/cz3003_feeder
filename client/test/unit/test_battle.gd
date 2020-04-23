extends "res://addons/gut/test.gd"

#var battle_services = preload("res://Battle_Services.gd")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


### Test Functions ###

func test_damage_dealt_1():
	var enemy_stats = {"attack" : 10, "hp" : 100}
	var user_stats = {"attack" : 10, "hp" : 100}
	var time_left = 28
	var timer_value = 30
	var result_hp = Battle_Services.deal_damage(user_stats,enemy_stats,time_left,timer_value)
	assert_eq(result_hp,60,"Normal use case")

func test_damage_dealt_2():
	var enemy_stats = {"attack" : 10, "hp" : 100}
	var user_stats = {"attack" : 10, "hp" : 100}
	var time_left = 0
	var timer_value = 30
	var result_hp = Battle_Services.deal_damage(user_stats,enemy_stats,time_left,timer_value)
	assert_ne(result_hp,100,"Test to see that at least some damage dealt")

func test_damage_taken_1():
	var enemy_stats = {"attack" : 10, "hp" : 100}
	var user_stats = {"attack" : 10, "hp" : 100}
	var time_left = 15
	var timer_value = 30
	var result_hp = Battle_Services.take_damage(user_stats,enemy_stats,time_left,timer_value)
	assert_eq(result_hp,80,"Normal use case")
	
func test_damage_taken_2():
	var enemy_stats = {"attack" : 10, "hp" : 100}
	var user_stats = {"attack" : 10, "hp" : 100}
	var time_left = 30
	var timer_value = 30
	var result_hp = Battle_Services.take_damage(user_stats,enemy_stats,time_left,timer_value)
	assert_ne(result_hp,100,"Test to see that you cannot avoid damage by spamming answers")

func test_check_answer_1():
	var choice
	var question = {"question" : "What are the types of requirements ?", 
		"a1": "Availability", 
		"a2": "Reliability",
		"a3": "Usability",
		"a4": "All of the mentioned",
		"answer":"All of the mentioned"}
	var selection = 4
	if selection == 1:
		choice = 0
	elif selection == 2:
		choice = 1
	elif selection == 3:
		choice = 2
	elif selection == 4:
		choice = 3
	else:
		print("error choice")
	var selected_ans = question["a"+str(choice +1)]
	var result = Battle_Services.check_answer(question,selected_ans)
	assert_true(result,"Choose the correct answer")

func test_check_answer_2():
	var choice
	var question = {"question" : "What are the types of requirements ?", 
		"a1": "Availability", 
		"a2": "Reliability",
		"a3": "Usability",
		"a4": "All of the mentioned",
		"answer":"All of the mentioned"}
	var selection = 3
	if selection == 1:
		choice = 0
	elif selection == 2:
		choice = 1
	elif selection == 3:
		choice = 2
	elif selection == 4:
		choice = 3
	else:
		print("error choice")
	var selected_ans = question["a"+str(choice +1)]
	var result = Battle_Services.check_answer(question,selected_ans)
	assert_false(result,"Choose the wrong answer")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
