class_name Job extends Creature

@export var currentJob : int = 1
@export var skillBoost : float = 0.0
@export var xp : int = 0
@export var enabled: bool = false

func _init(name : String, hp : int, atk : int, def : int, mAtk: int, mDef: int, level: int, specy : int, weapon : int, elt : int, rarity: int, portrait: String, art: String, skillBoost: float, enabled: bool):
	super(name, hp, atk, def, mAtk, mDef, level, specy, weapon, elt, rarity, portrait, art)
	self.skillBoost = skillBoost
	self.enabled = enabled
	pass


func addXp(xp: int):
	self.xp += xp

func unlock():
	self.enabled = true
