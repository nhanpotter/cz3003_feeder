extends KinematicBody2D


class_name OtherPlayer

export var speed : float = 300

onready var joystick_move := $UI/JoystickMove
onready var sprite = $Sprite


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
		
		

