class_name Skill extends Resource

@export var probability: float
@export var skill_name: String # todo could be constructed from Tiers + element + weapons...
@export var skill_effect: SkillEffect
@export var target_type : Constants.skill_targets

func _init(p_name: String, effect: SkillEffect, p_probability: float, target: Constants.skill_targets):
	skill_name = p_name
	skill_effect = effect
	probability = p_probability	
	target_type = target
	
