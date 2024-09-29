class_name CreatureStats extends Resource

@export var hp : int
@export var atk : int
@export var def : int
@export var mAtk : int
@export var mDef : int

func _init(p_hp : int, p_atk : int, p_def : int, p_mAtk: int, p_mDef: int): #p_ for parameter
	hp = p_hp
	atk = p_atk
	def = p_def
	mAtk = p_mAtk
	mDef = p_mDef
