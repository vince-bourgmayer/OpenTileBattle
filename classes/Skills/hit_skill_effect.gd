class_name HitSkillEffect extends SkillEffect

@export var weapon : Constants.weapons

func _init(p_tier: Constants.skill_tiers, p_elt: Constants.elements, p_weap: Constants.weapons):
	super(p_tier, p_elt, Constants.skill_effect_type.HIT)
	weapon = p_weap
	part_name_dic["SWORD"] = ["sword", "blade"]
	part_name_dic["SPEAR"] = ["spear", "strike"]
	part_name_dic["BOW"] = ["bow", "arrows"]

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
		var tierName = part_name_dic["NONE"][tier]
		var weaponSuffix = part_name_dic[Constants.weapons.keys()[weapon]][0]
		skillName = "%s%s" % [tierName, weaponSuffix]
	
	return skillName

func _apply(caster: BattleTile, target: BattleTile):
	super._apply(caster, target)
	var tier_power = get_dmg_tier_power()
	var weapon_carnage_bonus = Constants.get_weapon_carnage_bonus(weapon, target.weapon)
	var base_dmg = Constants.base_physical_skill_dmg(tier_power, caster.atk, target.def) * weapon_carnage_bonus
	var damage = Damage.new(base_dmg, elt, weapon)
	target.applyDmg(damage.dmg)
	target.add_child(DamageDisplayEffect.new(Vector2.ZERO, damage))

func get_dmg_tier_power():
	match tier:
		0:
			return 1.0
		1:
			return 2.0
		2:
			return 3.0
		3: 
			return 3.5
