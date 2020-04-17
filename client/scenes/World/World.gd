extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var init_flag = false

var background1 = preload("res://expedition_assets/background1.tscn")
var background2 = preload("res://expedition_assets/background2.tscn")
var background3 = preload("res://expedition_assets/background2.tscn")
var npc = preload("res://scenes/World/npc.tscn")
var player = preload("res://scenes/World/Player.tscn")
var background_instance
var npc_instance
var	player_instance
var npc_list_in_world = []
var last_npc_flag = false
var npc_reference #for referencing the npc node to be passed into the battle
var background_size 


# Called when the node enters the scene tree for the first time.
func _ready():
	while init_flag == false:
		pass
	print("world init completed!")
	#get_children_position()
	player_instance.spawn(randomize_spawn())
	for npc in npc_list_in_world:
		npc.spawn(Vector2(background_size))
		print(str(npc) + " has been spawned") #debug

	
	pass

func get_children_position():
	for node in get_children():
		if node.get_class() == "npc":
			print(node)
		elif node.get_class() == "player":
			print(node)
			
	pass

func init(params):
	print("world initializing with parameters : ") #debug
	print(params) #debug
	var background = params.pop_back()
	for enemy in params:
		create_npc(enemy)
	create_world_map(background)
	create_player()
	init_flag = true

func check_npc_status():
	var not_defeated_count = 0
	for node in get_children():
		if node.get_class() == "npc":
			if node.stats["is_defeated"] == false:
				not_defeated_count += 1
	if not_defeated_count == 1:
		last_npc_flag = true

func check_last_battle():
	if last_npc_flag == true: #means only one npc left and he is defeated
		print("defeated the last npc in this world!") #debug
		#create a popup
		for node in get_children():
			if node.get_class() == "Player":
				node.show_complete()
		for npc in npc_list_in_world:
			if npc.stats["is_defeated"] == false:
				npc.set_defeat()

		
		

func create_world_map(background_type):
	if background_type == 1:
		background_instance = background1.instance()
		add_child(background_instance)
		var cell_size = (background_instance.get_node("base").get_used_rect().size)
		background_size = 16 *cell_size
		print(background_size) #debug
	elif background_type == 2:
		background_instance = background2.instance()
		add_child(background_instance)
		var cell_size = (background_instance.get_node("base").get_used_rect().size)
		background_size = 64 *cell_size
		print(background_size) #debug
	elif background_type == 3:
		background_instance = background3.instance()
		add_child(background_instance)
		var cell_size = (background_instance.get_node("base").get_used_rect().size)
		background_size = 64 *cell_size
		print(background_size) #debug
	else:
		print("not a valid background type!")#debug

func create_npc(npc_data):
	print("this is npc data", npc_data)
	var sprite = Common_Services.get_enemy_sprite(npc_data.npc_avatar.npc_type)
	npc_instance = npc.instance()
	npc_instance.stats = npc_data
	npc_instance.get_child(0).set_texture(sprite)
	add_child(npc_instance)
	npc_list_in_world.append(npc_instance)
	


func create_player():
	player_instance = player.instance()
	add_child(player_instance)

func initiate_battle(npc):
	check_npc_status()
	npc_reference = null #clear previous npc reference
	print("initiating battle!") #debug
	print(npc.stats)
	Battle_Manager.set_enemy(npc.stats)
	Battle_Manager.set_self_stats()
	Battle_Manager.set_question_bank(npc.question_bank)
	var layer = CanvasLayer.new()
	layer.set_layer(2)	
	var diag = AcceptDialog.new()
	diag.get_label().text = "Challenge this opponent?"
	diag.connect("confirmed",self,"challenge_npc",[layer])
	layer.add_child(diag)
	self.add_child(layer)
	diag.popup_centered()	
	npc_reference = npc
	
	

func challenge_npc(layer):
	layer.queue_free()
	Battle_Manager.init_battle(self,npc_reference)
	hide_world()
	
	



func randomize_spawn():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_x = rng.randi_range(0+100,1080-100)
	rng.randomize()
	var random_y = rng.randi_range(0+100,540-100)
	return Vector2(random_x,random_y)

func hide_world():
	background_instance.visible = false
	for npc in npc_list_in_world:
		npc.visible = false
	player_instance.hide_player()
	
func show_world():
	background_instance.visible = true
	for npc in npc_list_in_world:
		npc.visible = true
	player_instance.show_player()

func delete_object(node):
	print("deleting the battle...")
	Battle_Manager.delete_battle()
	self.remove_child(node)
	node.queue_free()
	yield(get_tree(),"idle_frame")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


	
