extends KinematicBody2D

class_name Player

export var speed : float = 300

onready var joystick_move := $UI/JoystickMove
onready var sprite = $Sprite
const ACCEL = 25
const MAX_SPEED = 200
const FRICTION = 25
const RADIUS = 45

var velocity = Vector2.ZERO
var state:int = 1

func _ready():
	_dyanmicSpawn()
	
func _input(event):
	if(event.is_action("ui_down")):
		state = 1
		sprite.frame = 0
		_changingSprite()
	elif(event.is_action("ui_up")):
		state = 4
		sprite.frame = 12
		_changingSprite()
	elif(event.is_action("ui_left")):
		state = 2
		sprite.frame = 4
		_changingSprite()
	elif(event.is_action("ui_right")):
		state = 3
		sprite.frame = 8
		_changingSprite()
		




func _physics_process(delta: float) -> void:
	_move(delta)
	_betterMovement(delta)

	

func _move(delta: float) -> void:
	if joystick_move and joystick_move.is_working:
		move_and_slide(joystick_move.output * speed)
		
		

func _process(delta):
	if Input.is_key_pressed(KEY_A):
		if _withinOwnRadius():
			#print("hello")
			get_tree().change_scene("res://Scenes/battleScene/battleScene.tscn")
		else:
			print("not within range")

func _withinOwnRadius():
	var ownX = get_parent().get_node("Player").position.x
	var ownY = get_parent().get_node("Player").position.y
	var otherX = get_parent().get_node("OtherPlayer").position.x
	var otherY = get_parent().get_node("OtherPlayer").position.y

	if abs(int(ownX-otherX)) < RADIUS:
		if abs(int(ownY-otherY)) < RADIUS:
			return true
			
	return false


func _betterMovement(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCEL * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move_and_collide(velocity)
	
func _changingSprite():
	var minPos:int = (state-1) * 4 
	if minPos < 0:
		minPos = 0
	sprite.frame = ((sprite.frame+1)%4) + minPos	
		
func _dyanmicSpawn():
	var x = _randomNumberGenerator(0, _getDisplaySize().x-300)
	var y = _randomNumberGenerator(0, _getDisplaySize().y-300)
	get_parent().get_node("Player").position.x = x
	get_parent().get_node("Player").position.y = y
		

func _randomNumberGenerator(minValue: int, maxValue: int) -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(minValue, maxValue)

func _getDisplaySize():
	return get_viewport().size
	
	
