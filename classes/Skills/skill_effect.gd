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
		"FIRE" : ["Fire", "Inferno", "Solar Wind"],
		"ICE" : ["Ice", "Glacier", "Absolute Zero", "Solid State"],
		"LIGHTNING" : ["Thunder", "Lightning", "Tempest", "Electron"],
		"DARKNESS" : ["Shadow", "Darkness", "Dark matter", "Negation"],
		"NEUTRAL" : ["Trance", "Transcendance", "X-trem", "Ultim"],
		"NONE" : ["Mega", "Giga", "Tera", "Peta"],
	}

func _apply(caster: BattleTile, target: BattleTile):
	pass
