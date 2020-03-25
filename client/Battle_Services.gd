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
	print(random_number)
	return random_number

func check_answer(question,selected):
	if question.answer == selected:
		return true
	else: 
		return false

func deal_damage(self_stats,enemy_stats,time_left):
	print("dealing damage")
	var damage_dealt = self_stats["Attack"] * (time_left/2)
	var enemy_hp_left = enemy_stats["HP"] - damage_dealt
	return enemy_hp_left

func take_damage(self_stats,enemy_stats,time_left):
	print("taking damage")
	var damage_dealt = enemy_stats["Attack"] * (5-time_left)
	var self_hp_left = self_stats["HP"] - damage_dealt
	return self_hp_left

