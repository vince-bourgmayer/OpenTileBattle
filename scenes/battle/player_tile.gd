#extends StaticBody2D
class_name PlayerTile extends BattleTile

# Called when the node enters the scene tree for the first time.

var SkillBoost = 0.0

var playingAttackAnim = false
var attackTimer = Timer.new()

func _ready():
	attackTimer.wait_time = 1
	attackTimer.connect("timeout", Callable(_after_attackAnim))
	add_child(attackTimer)

func _process(_delta):
	super._process(_delta)
		
	if playingAttackAnim:
		var multiplier = 1
		if (attackTimer.time_left < 0.70):
			multiplier = -1
		var scaleRatio = multiplier * (attackTimer.time_left / attackTimer.wait_time)/120 +1
		apply_scale(Vector2(scaleRatio, scaleRatio))

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
	if (callback_dic != null):
		callback_dic["drag"].call(self)

func _on_button_button_up():
	if (callback_dic != null):
		callback_dic["drop"].call()
		
func playAttack():
	attackTimer.start()
	playingAttackAnim = true
	
func _after_attackAnim():
	attackTimer.stop()
	playingAttackAnim = false
	scale = Vector2(0.93,0.93)

func _on_area_2d_area_entered(area):
	var area_parent = area.get_parent()
	callback_dic["ally_collision"].call(self, area_parent)
	pass # Replace with function body.

