extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var reference_id 

# Called when the node enters the scene tree for the first time.
func _ready():
	print("my reference id is" + str(reference_id)) #debug
	pass # Replace with function body.

func set_reference_id(id):
	reference_id = int(id)	

func _on_Button_pressed():
	
	print("the id of this button is "+ str(reference_id)) #debug
	Expedition_Manager.init_expedition(reference_id)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
