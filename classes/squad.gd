class_name Squad


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
		0:
			position1 = character
		1:
			position2 = character
		2:
			position3 = character
		3:
			position4 = character
		4:
			position5 = character
		5:
			position6 = character

func getCharacter(position: int):
	match(position):
		0:
			return position1
		1:
			return position2
		2:
			return position3
		3:
			return position4
		4:
			return position5
		5:
			return position6
