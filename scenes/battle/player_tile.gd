#extends StaticBody2D
class_name PlayerTile extends BattleTile

# Called when the node enters the scene tree for the first time.

var SkillBoost = 0.0

var size: Vector2

func _ready():
	size = $button.size

func disable(val):
	$button.disabled = val
	
func setCreature(creature: Creature):
	super.setCreature(creature)
	$icon.setCreature(creature)
	SkillBoost = creature.skillBoost
	
func applyDmg(dmg):
	if !isAlive:
		return
	print("	<--- %s took %s dmg" % [creaName, dmg])

	$icon/life_bar.value = hp
	if !isAlive:
		set_collision_layer(0)
		playDeathEffect()
		

func _on_button_button_down():
	if (callback_dic.has("drag")):
		print("call")
		callback_dic["drag"].call(self)

func _on_button_button_up():
	if (callback_dic != null):
		callback_dic["drop"].call()
		
func playAttack():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.4)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.finished.connect(func(): scale = Vector2(0.93,0.93))



func _on_area_2d_area_entered(area):
	var area_parent = area.get_parent()
	callback_dic["ally_collision"].call(self, area_parent)
