extends Node

const levelmin	= 0
const levellower = 3
const levelupper = 7
const levelmax = 10

var user_stats = {}
#sample user stats : {attack:10, clan:Null, clan_owner:Null, experience:0, gender:2, gold:0, hp:100, id:2, level:1}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
#load sprite assets
func get_sprite(spriteId):
	var path = "res://common_assets/Character/" + spriteId + ".png"
	var sprite = load(path)
	return sprite
	pass

func get_spriteId(charLevel, charGender):
	if str(charGender) == "F" || str(charGender) == "2":
		if charLevel in range(levelmin,levellower):
			return "F1"
		elif charLevel in range(levellower,levelupper):
			return "F2"
		else:
			return "F3"
	elif str(charGender) == "M" || str(charGender) == "1":
		if charLevel in range(levelmin,levellower):
			return "M1"
		elif charLevel in range(levellower,levelupper):
			return "M2"
		else:
			return "M3"

func get_enemy_sprite(spriteId):
	var path = "res://common_assets/NPC/NPC" + str(spriteId) + ".png"
	var sprite = load(path)
	return sprite

func set_user_stats(stats):
	user_stats = stats

func get_user_stats():

	return user_stats

func get_avatar_info():
	Network_Services.get_avatar(self,"on_avatar_receive")

func on_avatar_receive(result,response_code,headers,body):
	print("testing") #debug
	var json = JSON.parse(body.get_string_from_utf8())
	var temp_stats = json.result
	Common_Services.set_user_stats(temp_stats)
	
