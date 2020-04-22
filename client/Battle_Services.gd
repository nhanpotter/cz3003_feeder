extends Node


var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# receives the question bank and the current active question if any and then returns the next question index
func get_next_question(QB,current):
	rng.randomize()
	var random_number = rng.randi_range(0,QB.size()-1)
	while random_number == current:
		random_number = rng.randi_range(0,QB.size()-1)
	print(random_number) #debug
	return random_number

func check_answer(question,selected):
	if question.answer == selected:
		return true
	else: 
		return false

func deal_damage(self_stats,enemy_stats,time_left,timer_value):
	time_left = float(time_left)
	timer_value = float(timer_value)
	print("damage dealt : ") #debug
	
	var damage_dealt = self_stats["attack"] * int((time_left/timer_value)*5)
	if damage_dealt == 0:
		damage_dealt = (self_stats["attack"]/2)
	print(damage_dealt) #debug
	var enemy_hp_left = enemy_stats["hp"] - damage_dealt
	print(enemy_hp_left) #debug
	Common_Services.get_user_stats()
	return enemy_hp_left

func take_damage(self_stats,enemy_stats,time_left,timer_value):
	time_left = float(time_left)
	timer_value = float(timer_value)
	print("taking damage : ") #debug
	var damage_dealt = enemy_stats["attack"]
	if int(time_left/timer_value) == 0:
		 damage_dealt = enemy_stats["attack"] * 2
	else:
		 damage_dealt = enemy_stats["attack"] * int((time_left/timer_value)*2)
	print(damage_dealt) #debug
	var self_hp_left = self_stats["hp"] - damage_dealt
	Common_Services.get_user_stats()
	return self_hp_left

