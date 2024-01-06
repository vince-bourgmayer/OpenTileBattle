class_name Stage

var title : String
var id : int
var achieved : bool
var starting_pos : Array[Vector2] = [] # starting pos for player character
var bg_path : String # path to background image
# var reward
var battle_foors : Array[Floor] = []
# var restriction
#var introduction

func _init(_id: int, _title: String):
	self.id = _id
	self.title = _title


func add_floor(battle_floor: Floor):
	battle_foors.append(battle_floor)

func get_battle_floor(id: int):
	if id < battle_foors.size():
		return battle_foors[id]
	return null
