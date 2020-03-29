extends Node

#get from database
var completedLevel
var textList

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func getCompletedLevel(params)->int:
	#get completedlevel from database
	var completedLevel = 4
	return completedLevel
	
