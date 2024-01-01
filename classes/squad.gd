class_name Squad

const characterClass = preload("res://classes/creature.gd")
@export var squadId : int
var position1 : Character = null
var position2 : Character = null
var position3 : Character = null
var position4 : Character = null
var position5 : Character = null
var position6 : Character = null

func _init():
	pass
	
func changeCharacter(position: int, character: Character):
	match(position):
		1:
			position1 = character
		2:
			position2 = character
		3:
			position3 = character
		4:
			position4 = character
		5:
			position5 = character
		6:
			position6 = character
