extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
#load sprite assets
func get_sprite(spriteId):
	var path = "res://common_assets/Character/" + spriteId
	var sprite = load(path)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
