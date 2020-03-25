extends Node2D


var q_bank = []
var timer_value = 0
var self_stats = {}
var enemy_stats = {}
var init_flag = false

#variables to track the current question
var current_question = 0 #gives the index of the question in the array of questions from q_bank
var index1 = 0
var index2 = 0
var index3 = 0
var index4 = 0

var rng = RandomNumberGenerator.new()
# Get the nodes that have to be programmed
onready var timer = get_node("Timer")
onready var timer_display = get_node("Timer_Display")
onready var question = get_node("Question")
onready var a1 = get_node("Answer1")
onready var a2 = get_node("Answer2")
onready var a3 = get_node("Answer3")
onready var a4 = get_node("Answer4")
onready var self_hp = get_node("Self_HP")
onready var enemy_hp = get_node("Enemy_HP")
onready var enemy_sprite = get_node("Enemy")

# Called when the node enters the scene tree for the first time.
func _ready():
	#loops to ensure init has finished before continuing
	while init_flag == false:
		pass
	#continue execution
	print("battle starting")
	self_hp.set_max(self_stats["HP"])
	enemy_hp.set_max(enemy_stats["HP"])
	_set_timer(timer_value)
	var next = Battle_Services.get_next_question(q_bank,0)
	#sets the current question index 
	current_question = next
	set_next_question(q_bank[current_question])



	pass # Replace with function body.


#initialize data for battle	
func init(params):
	timer_value = params["timer"]
	self_stats = Battle_Manager.get_self_stats()
	enemy_stats = Battle_Manager.get_enemy_stats()
	q_bank = Battle_Manager.get_question_bank(enemy_stats)
	

	#set flag to indicate initialization finished
	init_flag = true
	print("battle successfully initialized!")
	pass

func _set_timer(timer_value):
	
	timer.set_wait_time(timer_value)
	timer.connect("timeout",self,"_on_timeout")
	timer.set_one_shot(true)
	timer.start()

func set_next_question(qn):
	question.set_text(qn["question"])
	rng.randomize()
	var random = rng.randi_range(0,3)
	# get random numbers modulo 4 
	index1 = ((random + 4)%4)
	index2 = ((index1 + 1)%4)
	index3 = ((index2 + 1)%4)
	index4 = ((index3 + 1)%4)
	# set the questions in random order
	# questions should have the key a1 to a4
	a1.set_text(qn["a"+str(index1+1)])
	a2.set_text(qn["a"+str(index2+1)])
	a3.set_text(qn["a"+str(index3+1)])
	a4.set_text(qn["a"+str(index4+1)])
	_set_timer(timer_value)




func _on_Answer1_pressed():
	var q = q_bank[current_question]
	var selected_ans = q["a"+str(index1+1)]
	print(selected_ans)
	var time_left = int(timer.get_time_left())
	if Battle_Services.check_answer(q_bank[current_question],selected_ans) == true:
		print("correct answer selected")
		enemy_stats["HP"] = Battle_Services.deal_damage(self_stats,enemy_stats,time_left)
	else :
		print("wrong answer selected")
		self_stats["HP"] = Battle_Services.take_damage(self_stats,enemy_stats,time_left)
	_debug()
	_check_battle_end()
	var next = Battle_Services.get_next_question(q_bank,current_question)
	current_question = next
	set_next_question(q_bank[current_question])
	
		
	pass
func _on_Answer2_pressed():
	var q = q_bank[current_question]
	var selected_ans = q["a"+str(index2+1)]
	print(selected_ans)
	var time_left = int(timer.get_time_left())
	if Battle_Services.check_answer(q_bank[current_question],selected_ans) == true:
		print("correct answer selected")
		enemy_stats["HP"] = Battle_Services.deal_damage(self_stats,enemy_stats,time_left)
	else :
		print("wrong answer selected")
		self_stats["HP"] = Battle_Services.take_damage(self_stats,enemy_stats,time_left)
	_debug()
	_check_battle_end()
	var next = Battle_Services.get_next_question(q_bank,current_question)
	current_question = next
	set_next_question(q_bank[current_question])
	
	pass

func _on_Answer3_pressed():
	var q = q_bank[current_question]
	var selected_ans = q["a"+str(index3+1)]
	print(selected_ans)
	var time_left = int(timer.get_time_left())
	if Battle_Services.check_answer(q_bank[current_question],selected_ans) == true:
		print("correct answer selected")
		enemy_stats["HP"] = Battle_Services.deal_damage(self_stats,enemy_stats,time_left)
	else :
		print("wrong answer selected")
		self_stats["HP"] = Battle_Services.take_damage(self_stats,enemy_stats,time_left)
	_debug()
	_check_battle_end()
	var next = Battle_Services.get_next_question(q_bank,current_question)
	current_question = next
	set_next_question(q_bank[current_question])
	
	pass

func _on_Answer4_pressed():
	var q = q_bank[current_question]
	var selected_ans = q["a"+str(index4+1)]
	print(selected_ans)
	var time_left = int(timer.get_time_left())
	if Battle_Services.check_answer(q_bank[current_question],selected_ans) == true:
		print("correct answer selected")
		enemy_stats["HP"] = Battle_Services.deal_damage(self_stats,enemy_stats,time_left)
	else :
		print("wrong answer selected")
		self_stats["HP"] = Battle_Services.take_damage(self_stats,enemy_stats,time_left)
	_debug()
	_check_battle_end()
	var next = Battle_Services.get_next_question(q_bank,current_question)
	current_question = next
	set_next_question(q_bank[current_question])
	
	pass	

# handles what happens when timer runs out
func _on_timeout():
	print("timed out!")
	print("setting next question")
	#receive damage
	self_stats["HP"] = Battle_Services.take_damage(self_stats,enemy_stats,0)
	var hp_left = self_stats["HP"]
	_check_battle_end()
	if hp_left < 0:
		self_stats["HP"] = 0

	else:
		self_stats["HP"] = hp_left
	var next = Battle_Services.get_next_question(q_bank,current_question)
	current_question = next
	set_next_question(q_bank[current_question])

func _update_health_bars():
	self_hp.set_value(self_stats["HP"])
	enemy_hp.set_value(enemy_stats["HP"])
	
func _debug():
	print("Player health left = "+str(self_stats["HP"]))
	print("Enemy health left = "+str(enemy_stats["HP"]))

#check when the battle is over
func _check_battle_end():
	if self_stats["HP"] <= 0:
		Battle_Manager.resolve_battle("lose")
	elif enemy_stats["HP"] <= 0:
		Battle_Manager.resolve_battle("win")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_health_bars()
	
	timer_display.set_text(str(int(timer.get_time_left())))
	pass
