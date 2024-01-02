class_name Creature
	
@export var name : String
@export var hp : int
@export var maxHP: int
@export var atk : int
@export var def : int
@export var mAtk : int
@export var mDef : int
@export var level : int
# use enum in Constants.gd
@export var specy : int 
@export var weapon : int
@export var elt : int
@export var rarity : int

@export var portrait_path : String
@export var full_art_path : String

const ART_ROOT_PATH : String = "res://art/"
	
func _init(name : String, hp : int, atk : int, def : int, mAtk: int, mDef: int, level: int, specy : int, weapon : int, elt : int, rarity: int, portrait: String, art: String):
	self.name = name
	self.hp = hp
	self.maxHP = hp
	self.atk = atk
	self.def = def
	self.mAtk = mAtk
	self.mDef = mDef
	self.level = level
	self.specy = specy
	self.weapon = weapon
	self.elt = elt
	self.portrait_path = "%s%s" % [ART_ROOT_PATH, portrait]
	self.full_art_path = "%s%s" % [ART_ROOT_PATH, art]
	pass
