class_name Foe extends Creature


@export var move : int #number of tile that can be reached
@export var xp : int # amount of XP given when dying
@export var coins : int # amount of gold collected when dying

func _init(name : String, hp : int, atk : int, def : int, mAtk: int, mDef: int, level: int, specy : int, weapon : int, elt : int, rarity: int, portrait: String, art: String, move : int):
	super(name, hp, atk, def, mAtk, mDef, level, specy, weapon, elt, rarity, portrait, art)
	self.move = move
	pass
