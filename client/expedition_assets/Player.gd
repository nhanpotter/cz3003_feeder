	extends KinematicBody2D

class_name Player

export var speed : float = 300

onready var joystick_move := $UI/JoystickMove
onready var sprite = $Sprite
var x
const RADIUS = 45



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
		
		
		
		
	
	

func _dynamicSpawn():
	var x = _randomNumberGenerator(0, _getDisplaySize().x-300)
	var y = _randomNumberGenerator(0, _getDisplaySize().y-300)
	get_node("Sprite").position.x = x
	get_node("Sprite").position.y = y
	
		

func _randomNumberGenerator(minValue: int, maxValue: int) -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(minValue, maxValue)

func _getDisplaySize():
	return get_viewport().size

func _withinOwnRadius():
	var ownX = get_parent().get_node("Player").position.x
	var ownY = get_parent().get_node("Player").position.y
	#var otherX = get_tree().get_node("npc").get_node("Node2D/OtherNpc").position.x
	#var otherY = get_tree().get_node("npc").get_node("Node2D/OtherNpc").position.y
	#var otherY = get_child(1).position.y
	var otherX = -253.59225
	var otherY = 113.126877
	print("x = ", ownX, " y= ",ownY, " x2 = ",otherX," y2 = ", otherY)
	
	if abs(int(ownX-otherX)) < RADIUS:
		if abs(int(ownY-otherY)) < RADIUS:
			return true
			
	return false

func _on_actBtn_pressed():
		if _withinOwnRadius():
			#print("hello")
			print("CHANGE THAT SCENE")
		else:
			print("not within range")

