extends Button

export (String) var world

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _pressed():
	get_tree().change_scene(world)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
