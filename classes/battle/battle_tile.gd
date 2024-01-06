class_name BattleTile extends CharacterBody2D
signal died


var creaName : String
var maxHp : int
var hp : int
var id : int
var atk : int
var def : int
var mAtk : int
var mDef : int
var isAlive = true

var callback_dic : Dictionary
var timer_dic: Dictionary

var playingDeathEffect = false

func _init():
	var deathTimer = createDeathEffectTimer()
	add_child(deathTimer)
	timer_dic["death"] = deathTimer
	
	pass
	
func _process(_delta):
	if playingDeathEffect:
		playDyingEffect(_delta)

func set_callables(dictionary : Dictionary):
	callback_dic = dictionary

func setCreature(creature: Creature):
	creaName = creature.name
	maxHp = creature.hp
	hp = creature.hp
	atk = creature.atk
	def = creature.def
	mAtk = creature.mAtk
	mDef = creature.mDef

func applyDmg(dmg : int):
	if hp - dmg < 0:
		hp = 0
	else:
		hp -= dmg	
	if hp == 0:
		isAlive = false


func createDeathEffectTimer(): 
	var timer = Timer.new()
	timer.wait_time = 1
	
	var timeout_after_death_effect = Callable(func _after_deathEffect(timer):
		timer.stop()
		playingDeathEffect = false
		visible = false
		modulate.a = 1
		)
		
	timer.timeout.connect(timeout_after_death_effect.bind(timer))
	return timer

func playDyingEffect(_delta):
	var timer = timer_dic["death"]
	modulate.a = timer.time_left / timer.wait_time
	
func playDeathEffect():
	var timer = timer_dic["death"]
	timer.start()
	playingDeathEffect = true
