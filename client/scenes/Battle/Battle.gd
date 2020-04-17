extends Node2D


var q_bank = []
var timer_value = 0
var self_stats = {}
var enemy_stats = {}
var init_flag = false
var npc_ref 
var battle_result 

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
onready var enemy_sprite = get_node("ColorRect/Enemy")
onready var player_sprite = get_node("ColorRect/Player")
onready var transition = get_node("Transition/AnimationPlayer")
onready var resolve_button = get_node("ResolveButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	#loops to ensure init has finished before continuing
	while init_flag == false:
		pass
	#continue execution
	print("battle starting")
	print("enemy stats are : ") #debug
	print(enemy_stats) #debug
	print("player stats are :" ) #debug
	print(self_stats) #debug
	transition.play("Battle_Transition")
	self_hp.set_max(self_stats["hp"])
	enemy_hp.set_max(enemy_stats["npc_avatar"]["hp"])
	_set_timer(timer_value)
	_set_enemy_sprite(enemy_stats["npc_avatar"]["npc_type"])
	_set_self_sprite(self_stats["gender"],self_stats["level"])
	Analytics_Services.start_record()
	var next = Battle_Services.get_next_question(q_bank,0)
	#sets the current question index 
	current_question = next
	set_next_question(q_bank[current_question])



	pass # Replace with function body.


#initialize data for battle	
func init(params):
	print("this is battle no. " + str(params)) #debug
	timer_value = 20 #change dynamic later
	self.self_stats = Battle_Manager.get_self_stats().duplicate(true)
	self.enemy_stats = Battle_Manager.get_enemy_stats().duplicate(true)
	var q_bank_temp = Battle_Manager.get_question_bank().duplicate()
	q_bank = q_bank_temp["questions"]
	$Camera2D.current = true

	#set flag to indicate initialization finished
	init_flag = true
	print("battle successfully initialized!")
	pass

func get_npc_reference(npc_reference):
	npc_ref = null
	npc_ref = npc_reference


func _set_timer(timer_value):
	
	timer.set_wait_time(timer_value)
	timer.connect("timeout",self,"_on_timeout")
	timer.set_one_shot(true)
	timer.start()

func _set_enemy_sprite(id):
	var sprite = Common_Services.get_enemy_sprite(id)
	var size = Vector2(720,1080)
	enemy_sprite.set_texture(sprite)
	var position = Vector2(700,175)
	var scale = Vector2(0.5,0.5)
	enemy_sprite.set_position(position)
	enemy_sprite.set_scale(scale)
	enemy_sprite.set_z_index(0)
	
func _set_self_sprite(player_gender,player_level):
	var sprite = Common_Services.get_sprite(Common_Services.get_spriteId(player_level,player_gender))
	var size = Vector2(720,1080)
	player_sprite.set_texture(sprite)
	var position = Vector2(275,175)
	var scale = Vector2(0.5,0.5)
	player_sprite.set_position(position)
	player_sprite.set_scale(scale)
	player_sprite.set_z_index(0)

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

func _handle_answer_press(selection):
	var q = q_bank[current_question]
	var choice
	if selection == 1:
		choice = index1
	elif selection == 2:
		choice = index2
	elif selection == 3:
		choice = index3
	elif selection == 4:
		choice = index4
	else:
		print("error choice")
	var selected_ans = q["a"+str(choice +1)]
	Analytics_Services.add_question(q["question_id"],choice+1)
	print(selected_ans)
	var time_left = int(timer.get_time_left())
	if Battle_Services.check_answer(q_bank[current_question],selected_ans) == true:
		print("correct answer selected")
		self.enemy_stats["npc_avatar"]["hp"] = Battle_Services.deal_damage(self.self_stats,self.enemy_stats["npc_avatar"],time_left,timer_value)
	else :
		print("wrong answer selected")
		self.self_stats["hp"] = Battle_Services.take_damage(self.self_stats,self.enemy_stats["npc_avatar"],time_left,timer_value)
	_debug()
	if _check_battle_end() == true:
		timer.stop()
	else:
		var next = Battle_Services.get_next_question(q_bank,current_question)
		current_question = next
		set_next_question(q_bank[current_question])



func _on_Answer1_pressed():
	_handle_answer_press(1)		
	pass

func _on_Answer2_pressed():
	_handle_answer_press(2)	
	pass

func _on_Answer3_pressed():
	_handle_answer_press(3)	
	pass

func _on_Answer4_pressed():
	_handle_answer_press(4)
	pass	

# handles what happens when timer runs out
func _on_timeout():
	print("timed out!")
	print("setting next question")
	#receive damage
	self.self_stats["hp"] = Battle_Services.take_damage(self.self_stats,self.enemy_stats["npc_avatar"],0,timer_value)
	var hp_left = self_stats["hp"]
	_check_battle_end()
	if hp_left < 0:
		self.self_stats["hp"] = 0

	else:
		self.self_stats["hp"] = hp_left
	var next = Battle_Services.get_next_question(q_bank,current_question)
	current_question = next
	set_next_question(q_bank[current_question])

func _update_health_bars():
	self_hp.set_value(self.self_stats["hp"])
	enemy_hp.set_value(self.enemy_stats["npc_avatar"]["hp"])
	
func _debug():
	print("Player health left = "+str(self.self_stats["hp"]))
	print("Enemy health left = "+str(self.enemy_stats["npc_avatar"]["hp"]))

#check when the battle is over
func _check_battle_end():
	if self.self_stats["hp"] <= 0:
		Battle_Manager.resolve_battle("lose")
		resolve_battle(0)
		return true
	elif self.enemy_stats["npc_avatar"]["hp"] <= 0:
		Battle_Manager.resolve_battle("win")
		resolve_battle(1)
		return true
		
	
func resolve_battle(result):
	var resolve_text = get_node("ResolveText")
	var scroll_anim = get_node("ResolveText/Scroll")
	a1.visible = false
	a2.visible = false
	a3.visible = false
	a4.visible = false
	self_hp.visible = false
	enemy_hp.visible = false
	resolve_text.visible = true
	timer_display.visible = false
	timer.stop()

	if result == 1:
		battle_result = true
		enemy_sprite.get_node("AnimationPlayer").play("Fade")
		if enemy_stats["is_defeated"] == false:
			npc_ref.set_defeat()
			Network_Services.defeat_npc(self,"on_defeat_npc",enemy_stats["id"])
			question.set_text("Victory!")
			if (self_stats["experience"] + enemy_stats["experience"])>100: #check level up
				resolve_text.set_text("Leveled Up! You are now level : " +str(self_stats["level"]+1)+"\n"+"Gold gained : "
									+str(enemy_stats["gold"])+"\nExperience gained : "+str(enemy_stats["experience"]))
			else: 
				resolve_text.set_text("Gold gained : "+str(enemy_stats["gold"])+"\nExperience gained : "+str(enemy_stats["experience"]))
		else: #if defeated already, subsequent battles earn no gold or exp
			Network_Services.defeat_npc(self,"on_defeat_npc",enemy_stats["id"])
			question.set_text("Victory!")
			resolve_text.set_text("Gold gained : "+str(0)+"\nExperience gained : "+str(0))
	else:
		battle_result = false
		player_sprite.get_node("AnimationPlayer").play("Fade")
		question.set_text("Defeat!")
		resolve_text.set_text("You have been defeated")


	scroll_anim.connect("animation_finished",self,"_on_Scroll_animation_finished")
	scroll_anim.play("Scroll Text")

	pass

func on_defeat_npc(result,response_code,headers,body):
	print("npc defeat request resolved!") #debug
	

func _on_Scroll_animation_finished(anim_name):
	print("animation finished!") #debug
	
	resolve_button.visible = true
	pass

func _on_ResolveButton_pressed():
	Analytics_Services.stop_record()
	end_battle()

func clear_cache():
	self.battle_result = null
	self.npc_ref = null
	self.q_bank = []
	self.timer_value = 0
	self.self_stats = {}
	self.enemy_stats = {}
	self.init_flag = false
	print("after clearing cache :")
	print(q_bank)
	print(timer_value)
	print(self_stats)
	print(enemy_stats)
	print(init_flag)

func end_battle():
	if battle_result == true:
		get_parent().check_last_battle()
	get_parent().show_world()
	clear_cache()
	for child in get_children():
		child.queue_free()
	get_parent().delete_object(self)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_health_bars()
	
	timer_display.set_text(str(int(timer.get_time_left())))
	pass
