class_name Skill extends Resource

@export var probability: float
@export var skill_name: String
@export var element: Constants.elements
@export var weapon: Constants.weapons
@export var power: float #todo or should I use 'Tier'
var unlocked : bool = false
var level_condition: int = 0
var effect_area : Constants.skillTargets

func _init(p_name: String, p_elt: Constants.elements, p_weap: Constants.weapons, p_power: float, p_probability: float):
	skill_name = p_name
	element = p_elt
	weapon = p_weap
	power = p_power
	probability = p_probability	
	
