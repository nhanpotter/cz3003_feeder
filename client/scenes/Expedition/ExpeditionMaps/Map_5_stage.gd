extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var green_button = preload("res://common_assets/Map/green button.png")
var red_button = preload("res://common_assets/Map/red button.png")
onready var stage5 = $Stage5
onready var stage4 = $Stage4
onready var stage3 = $Stage3
onready var stage2 = $Stage2
onready var stage1 = $Stage1
var worlds = []



# Called when the node enters the scene tree for the first time.
func _ready():
	
	worlds = get_parent().get_parent().get_worlds()
	_initialize_stages(worlds)
	pass # Replace with function body.


func _initialize_stages(worlds):
	var stages = [stage1,stage2,stage3,stage4,stage5]
	var count = 0
	for world in worlds:
		if count <4:
			if world["is_finished"] == true:
				
				stages[count+1].set_texture(green_button)
				pass
			else:
				
				stages[count+1].set_texture(red_button)
				pass
			count = count + 1
		print("count is now : " + str(count)) #debug
	stage1.set_texture(green_button)	



func _check_level(button):
	if button.get_texture() == red_button:
		return false
	else:
		return true



func _display_level_lock():
	var layer = CanvasLayer.new()
	layer.set_layer(2)
	
	var diag = AcceptDialog.new()
	diag.get_label().text = "Please complete the previous stage first!"
	diag.connect("confirmed",self,"_clean_dialog")
	layer.add_child(diag)
	self.add_child(layer)
	diag.popup_centered()	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button1_pressed():
	if _check_level($Stage1) == false:
		_display_level_lock()
	else:
		print("entering world..") #debug
		World_Manager.init_world(worlds[0])
	pass

func _on_Button2_pressed():
	if _check_level($Stage2) == false:
		_display_level_lock()
	else:
		print("entering world..") #debug
		World_Manager.init_world(worlds[1])
	pass

func _on_Button3_pressed():
	if _check_level($Stage3) == false:
		_display_level_lock()
	else:
		print("entering world..") #debug
		World_Manager.init_world(worlds[2])
	pass

func _on_Button4_pressed():
	if _check_level($Stage4) == false:
		_display_level_lock()
	else:
		print("entering world..") #debug
		World_Manager.init_world(worlds[3])
	pass

func _on_Button5_pressed():
	if _check_level($Stage5) == false:
		_display_level_lock()
	else:
		print("entering world..") #debug
		World_Manager.init_world(worlds[4])
	pass
