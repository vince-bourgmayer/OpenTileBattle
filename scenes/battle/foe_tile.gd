#extends StaticBody2D
extends BattleTile

# Called when the node enters the scene tree for the first time.
static var counter = 0

var destination: Vector2
var move : int

func _ready():
	counter += 1
	destination = position

func _process(_delta):
	super._process(_delta)
	
func setCreature(foe: Creature):
	$icon.setCreature(foe)
	id = counter
	super.setCreature(foe)
	
func applyDmg(dmg: int):
	if !isAlive:
		return
		
	super.applyDmg(dmg)
	print("	---> %s %s took %s dmg" % [creaName, id, dmg])
	
	$icon/life_bar.value = hp
	if !isAlive:
		set_collision_layer(0)
		playDeathEffect()
