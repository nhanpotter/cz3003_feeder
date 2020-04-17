extends Node2D
class_name npc
onready var sprite = get_node("Sprite")
onready var sprite_hitbox = get_node("CollisionShape2D")
var npc_sprite1 = preload("res://expedition_assets/test_npc.png")
var npc_ready_flag = false #use to signal when npc has collected all data it needs, others cant interact with it if false
var stats = {} #debug
var question_bank = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#set_sprite(stats["npc_avatar"]["npc_type"])
	
	Network_Services.get_question_bank_detail(self,"handle_question_bank",stats["question_bank"])
	print("Enemy loaded with data : " + str(stats["npc_avatar"]))
	show_marker()

	
	
	pass

func handle_question_bank(result,response_code,headers,body):
	var json = JSON.parse(body.get_string_from_utf8())
	question_bank = json.result
	print("question bank data is...") #debug
	
	print(question_bank) #debug
	npc_ready_flag = true

func show_marker():
	if self.stats["is_defeated"]== false:
		var marker = get_node("Sprite/Marker")
		marker.visible = true

func set_defeat():
	self.stats["is_defeated"] = true
	var marker = get_node("Sprite/Marker")
	marker.visible = false
	
func set_sprite(npc_id):
	if npc_id == 1:
		sprite.set_texture(npc_sprite1)
	elif npc_id == 2:
		sprite.set_texture(npc_sprite1)
	elif npc_id == 3:
		sprite.set_texture(npc_sprite1)
	elif npc_id == 4:
		sprite.set_texture(npc_sprite1)
	elif npc_id == 5:
		sprite.set_texture(npc_sprite1)
	elif npc_id == 6:
		sprite.set_texture(npc_sprite1)

func get_current_position():
	
	return sprite.get_global_position()

#function to be called when player interacts with npc
func player_interaction():
	if npc_ready_flag == true:
		print("called from npc...") #debug
		get_parent().initiate_battle(self)
	else:
		print("npc is not ready!!") #debug

func get_class():
	return "npc"

func spawn(spawn_vector):
	var new_spawn = Vector2(float(spawn_vector.x) * float(self.stats["pos_X"]),float(spawn_vector.y) * float(self.stats["pos_Y"])) 
	sprite.global_position=(new_spawn)
	sprite_hitbox.global_position=(new_spawn)

func randomize_spawn():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_x = rng.randi_range(0+100,1080-100)
	rng.randomize()
	var random_y = rng.randi_range(0+100,540-100)
	return Vector2(random_x,random_y)

func battle_prompt():
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

