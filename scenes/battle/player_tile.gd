extends StaticBody2D

signal died

var callable_dic
# Called when the node enters the scene tree for the first time.
static var counter = 0

var creaName
var id
var atk
var def
var mAtk
var mDef
var SkillBoost = 0.0
var isPlayerOwned = false
var isAlive = true

# 'anim' For test
var playingDeathAnim = false
var playingAttackAnim = false
var dyingTimer = Timer.new()
var attackTimer = Timer.new()

func _ready():
	counter += 1
	dyingTimer.wait_time = 1
	dyingTimer.connect("timeout", Callable(_after_deathAnim))
	add_child(dyingTimer)
	attackTimer.wait_time = 1
	attackTimer.connect("timeout", Callable(_after_attackAnim))
	add_child(attackTimer)

func _process(_delta):
	if playingDeathAnim:
		modulate.a = dyingTimer.time_left / dyingTimer.wait_time
		
	if playingAttackAnim:
		var multiplier = 1
		if (attackTimer.time_left < 0.70):
			multiplier = -1
		var scaleRatio = multiplier * (attackTimer.time_left / attackTimer.wait_time)/120 +1
		apply_scale(Vector2(scaleRatio, scaleRatio))
		#apply_scale(Vector2(scaleValue, scaleValue))

func set_callables(dictionnary):
	callable_dic = dictionnary

func disable(val):
	$button.disabled = val
	
func setCreature(creature):
	$icon.setCreature(creature)
	id = counter
	creaName = creature.name
	atk = creature.atk
	def = creature.def
	mAtk = creature.mAtk
	mDef = creature.mDef
	if (creature is Job):
		SkillBoost = creature.skillBoost
		isPlayerOwned = true
	
func applyDmg(dmg):
	if !isAlive:
		return
	if isPlayerOwned:
		print("	<--- %s took %s dmg" % [creaName, dmg])
	else:
		print("	---> %s %s took %s dmg" % [creaName, id, dmg])
	
	$icon/life_bar.value -= dmg
	if $icon/life_bar.value == 0:
		isAlive = false

func _on_button_button_down():
	if (callable_dic != null):
		callable_dic["drag"].call(self)

func _on_button_button_up():
	if (callable_dic != null):
		callable_dic["drop"].call(self)
		
		
func playAttack():
	attackTimer.start()
	playingAttackAnim = true
	
func playDeath():
	dyingTimer.start()
	playingDeathAnim = true
	
	
func _after_deathAnim():
	dyingTimer.stop()
	playingDeathAnim = false
	visible = false
	modulate.a = 1
	
func _after_attackAnim():
	attackTimer.stop()
	playingAttackAnim = false
	scale = Vector2(0.93,0.93)
