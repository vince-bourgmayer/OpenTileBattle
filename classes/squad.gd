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

func getCharacter(position: int):
	match(position):
		1:
			return position1
		2:
			return position2
		3:
			return position3
		4:
			return position4
		5:
			return position5
		6:
			return position6
