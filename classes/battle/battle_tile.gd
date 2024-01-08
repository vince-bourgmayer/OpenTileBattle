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
var elt : Constants.elements = Constants.elements.NONE
var weapon : Constants.weapons = Constants.weapons.STAFF

var callback_dic : Dictionary

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
	elt = creature.elt
	weapon = creature.weapon

func applyDmg(dmg : int):
	if hp - dmg < 0:
		hp = 0
	else:
		hp -= dmg	
	if hp == 0:
		isAlive = false

func playDeathEffect():
	var modified_modulate = modulate
	modified_modulate.a = 0
	var tween = get_tree().create_tween()
	tween.tween_interval(0.7)
	tween.tween_property(self, "modulate", modified_modulate, 1)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.finished.connect(func():
		visible = false
		modulate.a = 1)

func get_cell_pos():
	return Constants.get_grid_cell_for_pos(position)
