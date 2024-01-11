class_name Creature extends Resource
	
@export var name : String
@export var stats: CreatureStats
@export var level : int
# use enum in Constants.gd
@export var specy : Constants.species 
@export var weapon : Constants.weapons
@export var elt : Constants.elements
@export var rarity : Constants.rarities

@export var portrait_path : String
@export var full_art_path : String

const ART_ROOT_PATH : String = "res://art/"
	
func _init(name : String, p_stats: CreatureStats, level: int, specy : int, weapon : int, elt : int, rarity: int, portrait: String, art: String):
	self.name = name
	stats = p_stats
	self.level = level
	self.specy = specy
	self.weapon = weapon
	self.elt = elt
	self.portrait_path = "%s%s" % [ART_ROOT_PATH, portrait]
	self.full_art_path = "%s%s" % [ART_ROOT_PATH, art]
