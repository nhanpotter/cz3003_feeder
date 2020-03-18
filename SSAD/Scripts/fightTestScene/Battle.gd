extends Node2D

var x
var q1 = {"question" : "1 + 1 = ?", "a1" : "1", "a2" : "2", "a3" : "3", "a4" : "4"}
var q2 = {"question" : "2 + 2 = ?", "a1" : "2", "a2" : "4", "a3" : "6", "a4" : "8"}
var q3 = {"question" : "3 + 3 = ?", "a1" : "3", "a2" : "6", "a3" : "9", "a4" : "12"}
var q4 = {"question" : "4 + 4 = ?", "a1" : "4", "a2" : "8", "a3" : "12", "a4" : "16"}
var rng = RandomNumberGenerator.new()
var QuestionBank = [q1,q2,q3,q4]
var DisplayValue = 10
onready var timer = get_node("Timer")
onready var timerDisplay = get_node("TimerDisplay")
onready var question = get_node("Question")
onready var answer1 = get_node("Answer1")
onready var answer2 = get_node("Answer2")
onready var answer3 = get_node("Answer3")
onready var answer4 = get_node("Answer4")
onready var self_hp = get_node("Self_HP")
onready var enemy_hp = get_node("Enemy_HP")

#use init to get all data needed for timed battles
func _init():
	#init character data
	#init enemy data
	#init question banks
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_timer()
	var next = get_next_question(QuestionBank)
	set_next_question(next)
	self_hp.set_text(str(100))
	enemy_hp.set_text(str(100))

	#pass

func _process(_delta):
	DisplayValue = int(timer.get_time_left())
	timerDisplay.set_text(str(DisplayValue))
	#handle what to do on win/loss here
	if int(self_hp.get_text()) <= 0:
		print("You died.")
		get_tree().quit()
	elif int(enemy_hp.get_text()) <=0:
		print("You won!")
		get_tree().quit()


func _set_timer():
	timer.set_wait_time(10)
	timer.connect("timeout",self,"_on_timeout")
	timer.set_one_shot(true)
	timer.start()

func _on_timeout():
	timerDisplay.set_text("Timed out!")
	print("Timed out!")
	print("setting next question...")
	#this damage is the default timer value, hardcoded to 10 for now
	take_damage(0)
	var next = get_next_question(QuestionBank)
	set_next_question(next)




# function to get the next set of question with answers
func get_next_question(QB):
	rng.randomize()
	var random_number = rng.randi_range(0,QB.size()-1)
	return QB[random_number]

func set_next_question(Q):
	question.set_text(Q["question"])
	answer1.set_text(Q["a1"])
	answer2.set_text(Q["a2"])
	answer3.set_text(Q["a3"])
	answer4.set_text(Q["a4"])

#primitive check answer for now, to be further refined
func check_answer():
	pass

func deal_damage(t_value):
	var time_damage_factor = t_value
	var damage = time_damage_factor
	#damage = damage * self_attack
	var newhp = int(enemy_hp.get_text()) - damage
	enemy_hp.set_text(str(newhp))

	

func take_damage(t_value):
	var time_damage_factor = 10-t_value
	var damage = time_damage_factor
	#damage = damage * question_difficulty
	var newhp = int(self_hp.get_text()) - damage
	self_hp.set_text(str(newhp))

	
	


func _on_Answer1_pressed():
	print("timer current value is :")
	var t_value = int(timer.get_time_left())
	print(str(t_value))
	
	take_damage(t_value)
	var next = get_next_question(QuestionBank)
	set_next_question(next)
	_set_timer()


func _on_Answer2_pressed():
	print("timer current value is :")
	var t_value = int(timer.get_time_left())
	print(str(t_value))
	
	deal_damage(t_value)
	var next = get_next_question(QuestionBank)
	set_next_question(next)
	_set_timer()


func _on_Answer3_pressed():
	print("timer current value is :")
	var t_value = int(timer.get_time_left())
	print(str(t_value))
	
	take_damage(t_value)
	var next = get_next_question(QuestionBank)
	set_next_question(next)
	_set_timer()


func _on_Answer4_pressed():
	print("timer current value is :")
	var t_value = int(timer.get_time_left())
	print(str(t_value))
	take_damage(t_value)
	var next = get_next_question(QuestionBank)
	set_next_question(next)
	_set_timer()

#TODO:
#Get QuestionBank from JSON object
#Check answer refined so that it isn't hardcoded
#exit the script nicely on win/lose


func _on_backbutton_pressed():
	x = get_tree().change_scene("res://Scenes/mainMenuScene/mainMenuScene.tscn")
	pass # Replace with function body.
