class_name SkillsList extends Resource

@export var skills : Array[Skill] = [] #todo should rather be Dictionary to save name as key

func _init():
	_generate_test_skills()
	pass
	
	
func _generate_test_skills():
	var megaSword_effect = HitSkillEffect.new(Constants.skill_tiers.TIER_1, Constants.elements.NONE, Constants.weapons.SWORD)
	var ms_name = megaSword_effect.buildName()
	
	var gigaSword_effect = HitSkillEffect.new(Constants.skill_tiers.TIER_2, Constants.elements.NONE, Constants.weapons.SWORD)
	var gs_name = gigaSword_effect.buildName()
	
	var fire_sword = HitSkillEffect.new(Constants.skill_tiers.TIER_1, Constants.elements.FIRE, Constants.weapons.SWORD)
	var fs_name = fire_sword.buildName()
	
	var inferno = HitSkillEffect.new(Constants.skill_tiers.TIER_2, Constants.elements.FIRE, Constants.weapons.STAFF)
	var inferno_name = inferno.buildName()
	
	print("skill effect name: %s" % ms_name)
	print("skill effect name: %s" % gs_name)
	print("skill effect name: %s" % fs_name)
	print("skill effect name: %s" % inferno_name)
