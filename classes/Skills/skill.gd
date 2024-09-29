class_name Skill extends Resource

@export var probability: float
@export var skill_name: String # todo could be constructed from Tiers + element + weapons...
@export var skill_effect : SkillEffect
@export var target_type : Constants.skill_targets

var target_area: Dictionary = {
	"LATERAL" : [Vector2(-1,0), Vector2(1,0)],
	"VERTICAL" : [Vector2(0,-1), Vector2(0,1)],
	"AREA" : [Vector2(-1,-1), Vector2(0,-1), Vector2(1,-1), Vector2(-1,0), Vector2(1,0),Vector2(-1,1), Vector2(0,1), Vector2(1,1)]
}

func _init(p_name: String, effect: SkillEffect, p_probability: float, target: Constants.skill_targets):
	skill_name = p_name
	skill_effect = effect
	probability = p_probability	
	target_type = target
	
func perform(caster: BattleTile, foes: Array[BattleTile]):
	for foe in foes:
		if !foe.isAlive:
			continue
		if is_foe_in_taget_area(caster, foe):
			print("%s is touched by %s" % [foe.creaName, skill_name])
			skill_effect._apply(caster, foe)
		

func is_foe_in_taget_area(caster: BattleTile, foe: BattleTile):
	var vectors_area = target_area[Constants.skill_targets.keys()[target_type]]
	for vector in vectors_area:
		var foe_pos = foe.get_cell_pos()
		var computedVector = caster.get_cell_pos() + vector
		if foe_pos == computedVector:
			return true
	return false
	
