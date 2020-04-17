extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var data = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_record():
	data = [] #clear from previous battle

func add_question(question_id,choice):
	var question = {"question": question_id, "choice" : choice}
	data.append(question)

func stop_record():
	Network_Services.send_battle_history(self,"on_stop_record",data)
	print(data)

func on_stop_record(result,response_code,headers,body):
	print("data successfully sent!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
