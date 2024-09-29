class_name Stage extends Resource

@export var title : String
@export var id : int
@export var achieved : bool
@export var starting_pos : Array[Vector2] = [] # starting pos for player character
@export var bg_path : String # path to background image

@export var battle_foors : Array[Floor] = []
# var reward
# var restriction
# var introduction

func _init(stageId: int, stageTitle: String):
	id = stageId
	title = stageTitle

func add_floor(battle_floor: Floor):
	battle_foors.append(battle_floor)

func get_battle_floor(id: int):
	if id < battle_foors.size():
		return battle_foors[id]
	return null
