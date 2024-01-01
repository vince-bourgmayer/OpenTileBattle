class_name Foe

extends "res://classes/creature.gd"


@export var move : int #number of tile that can be reached


func _init(name : String, hp : int, atk : int, def : int, mAtk: int, mDef: int, level: int, specy : int, weapon : int, elt : int, rarity: int, portrait: String, art: String, move : int):
	super(name, hp, atk, def, mAtk, mDef, level, specy, weapon, elt, rarity, portrait, art)
	self.move = move
	pass
