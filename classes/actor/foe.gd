class_name Foe extends Creature


@export var move : int #number of tile that can be reached
@export var xp : int # amount of XP given when dying
@export var coins : int # amount of gold collected when dying

func _init(name : String, stats: CreatureStats, level: int, specy : int, weapon : int, elt : int, rarity: int, portrait: String, art: String, move : int):
	super(name, stats, level, specy, weapon, elt, rarity, portrait, art)
	self.move = move
