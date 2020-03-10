extends VBoxContainer

# currently hardcoded modules
# [name of module, String path to load expedition/ world selection screen]
var _get_modules = [['Databases', 'res://lobby/module_selection/module1_background.tscn'], 
['Software Engineering',''], ['Python',''], ['AI','']]
	
# load the module button script
onready var mobule_button = preload("res://lobby/module_button.gd")

func _ready():
	_set_modules()

# create n number of buttons and label each button 
# n - number of modules taken by student
# label each button with module name
func _set_modules():
	# to-do: _get_modules change to function call 
	for row in _get_modules:
		var moduleButton = mobule_button.ModuleButton.new()
		moduleButton.text = row[0]
		moduleButton._set_expedition(row[1])
		add_child(moduleButton)

