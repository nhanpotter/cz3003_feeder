extends Node2D

# level related stuff
export (int) var level
# level to load when button is pressed
export (String) var level_to_load
# determines if prerequisite level is met and if button can be clicked
export (bool) var score_goal_met

# texture related stuff
export (Texture) var blocked_texture
export (Texture) var open_texture

onready var level_label = $TextureButton/Label
onready var button = $TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()

func setup():
	level_label.text = String(level)
	
	# set button texture. score_goal_met - green button, else - red button
	if score_goal_met:
		button.texture_normal = open_texture
	else:
		button.texture_normal = blocked_texture

# function called when pressed. change scene if button is enabled (score_goal_met = true)
func _on_TextureButton_pressed():
	if score_goal_met:
# warning-ignore:return_value_discarded
		get_tree().change_scene(level_to_load) # Replace with function body.
	else:
		alert("You are not ready for this level.\nPass the previous ones first.", "Error")
		
# dialog box alert 
# use case: when player presses the red button
func alert(text: String, title: String='Message') -> void:
	var dialog = AcceptDialog.new()
	dialog.dialog_text = text
	dialog.window_title = title
	dialog.connect('modal_closed', dialog, 'queue_free')
	add_child(dialog)
	dialog.popup_centered()
