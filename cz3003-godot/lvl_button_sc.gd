extends Node2D

# level related stuff
export (int) var level
# level to load when button is pressed
export (String) var level_to_load
# determines if prerequisite level is met and if button can be clicked
export (bool) var enabled
export (bool) var score_goal_met

# texture related stuff
export (Texture) var blocked_texture
export (Texture) var open_texture

onready var level_label = $TextureButton/Label
onready var button = $TextureButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	setup()

func setup():
	level_label.text = String(level)
	
	# set button texture
	if enabled:
		button.texture_normal = open_texture
	else:
		button.texture_normal = blocked_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	if enabled:
		get_tree().change_scene(level_to_load) # Replace with function body.
