extends KinematicBody2D

class_name Player

export var speed : float = 300

onready var joystick_move := $UI/JoystickMove

var x
const RADIUS = 45
onready var sprite = get_node("Sprite")
onready var detect_radius = get_node("Area2D")
onready var sprite_hitbox = get_node("CollisionShape2D")

func _ready():
	print("player instance loaded!")



func _input(event):
	if(event.is_action("ui_down")):
		sprite.frame = 0
	elif(event.is_action("ui_up")):
		sprite.frame = 12
	elif(event.is_action("ui_left")):
		sprite.frame = 4
	elif(event.is_action("ui_right")):
		sprite.frame = 8
	


func _physics_process(delta: float) -> void:
	_move(delta)
	

	

func _move(delta: float) -> void:
	if joystick_move and joystick_move.is_working:
		move_and_slide(joystick_move.output * speed)
		

func _getDisplaySize():
	return get_viewport().size


func _on_actBtn_pressed():
	print("my current position is :" + str(sprite.global_position))
	
	
	var list = detect_radius.get_overlapping_bodies()
	for node in list:
		if node.get_class() == "npc":
			print(node) #debug
			node.player_interaction()
			#get_parent().hide_world()
			#hide_player()

func get_class():
	return "Player"


func hide_player():
	$UI.get_child(0).visible = false
	$UI.get_child(1).visible = false
	$UI.get_child(2).visible = false
	self.visible = false
	$Camera2D.current = false

func show_player():
	$UI.get_child(0).visible = true
	$UI.get_child(1).visible = true
	$UI.get_child(2).visible = true
	self.visible = true
	$Camera2D.current = true

func spawn(spawn_vector):
	
	#sprite_hitbox.set_global_position(spawn_vector)
	#detect_radius.set_global_position(spawn_vector)
	self.set_global_position(spawn_vector)

func randomize_spawn():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_x = rng.randi_range(0+100,1080-100)
	rng.randomize()
	var random_y = rng.randi_range(0+100,540-100)
	return Vector2(random_x,random_y)

func _on_QuitButton_pressed():
	var layer = CanvasLayer.new()
	layer.set_layer(2)
	
	var diag = AcceptDialog.new()
	diag.get_label().text = "Confirm Exit World?"
	diag.connect("confirmed",self,"_confirm_exit")
	layer.add_child(diag)
	self.add_child(layer)
	diag.popup_centered()	

func show_complete():
	var complete = get_node("UI/Complete")
	complete.visible = true

func _on_Ok_pressed():
	var complete = get_node("UI/Complete")
	complete.visible = false

func _confirm_exit():
	#Expedition_Lobby_Manager.expedition_list = [] #clear cache
	var path = Scene_Manager.get_scene_path("mainmenu")
	Scene_Manager.goto_scene(path,0)
