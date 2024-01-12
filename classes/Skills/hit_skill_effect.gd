class_name HitSkillEffect extends SkillEffect

@export var weapon : Constants.weapons

func _init(p_tier: Constants.skill_tiers, p_elt: Constants.elements, p_weap: Constants.weapons):
	super(p_tier, p_elt, Constants.skill_effect_type.HIT)
	weapon = p_weap
	part_name_dic[Constants.weapons.keys()[Constants.weapons.SWORD]] = ["sword", "blade"]
	part_name_dic[Constants.weapons.keys()[Constants.weapons.SPEAR]] = ["spear", "strike"]
	part_name_dic[Constants.weapons.keys()[Constants.weapons.BOW]] = ["bow", "arrows"]

func buildName():
	var skillName: String
	if elt != Constants.elements.NONE:
		var elementalName: String = part_name_dic[Constants.elements.keys()[elt]][tier]
		var weaponName: String
		if weapon != Constants.weapons.STAFF:
			weaponName = part_name_dic[Constants.weapons.keys()[weapon]][1]
			skillName = "%s %s" % [elementalName, weaponName]
		else:
			skillName = "%s" % elementalName
	else:
		var tierName = part_name_dic[Constants.elements.keys()[Constants.elements.NONE]][tier]
		var weaponSuffix = part_name_dic[Constants.weapons.keys()[weapon]][0]
		skillName = "%s%s" % [tierName, weaponSuffix]
	
	return skillName


