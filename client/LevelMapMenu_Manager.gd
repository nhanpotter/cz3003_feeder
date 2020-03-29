extends Node

#get from database
var completedLevel
var textList

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
func getTextList(params)->Array:
	var textList = ["MODULE A", "MODULE B", "MODULE C", "MODULE D","A","A","A","A","A","A","A","A"]
	#var textList = ["MODULE A", "MODULE B", "MODULE C", "MODULE D"]
	#get textlist from database
	return textList



