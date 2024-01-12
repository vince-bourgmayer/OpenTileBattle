class_name SkillEffect extends Resource

@export var tier: Constants.skill_tiers
@export var elt : Constants.elements
@export var type: Constants.skill_effect_type

var part_name_dic: Dictionary

func _init(p_tier: Constants.skill_tiers, p_elt: Constants.elements, p_type: Constants.skill_effect_type):
	tier = p_tier
	elt = p_elt
	type = p_type
	
	part_name_dic = {
		Constants.elements.keys()[Constants.elements.FIRE] : ["Fire", "Inferno", "Solar Wind"],
		Constants.elements.keys()[Constants.elements.ICE] : ["Ice", "Glacier", "Absolute Zero", "Solid State"],
		Constants.elements.keys()[Constants.elements.LIGHTNING] : ["Thunder", "Lightning", "Tempest", "Electron"],
		Constants.elements.keys()[Constants.elements.DARKNESS] : ["Shadow", "Darkness", "Dark matter", "Negation"],
		Constants.elements.keys()[Constants.elements.NEUTRAL] : ["Trance", "Transcendance", "X-trem", "Ultim"],
		Constants.elements.keys()[Constants.elements.NONE] : ["Mega", "Giga", "Tera", "Peta"],
	}
