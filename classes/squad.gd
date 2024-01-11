class_name Squad extends Resource

@export var id : int
@export var members: Dictionary = Dictionary()

func _init(squadId: int):
	id = squadId
	
func changeCharacter(position: int, character: Character):
	if position in range(0, 5):
		members[position] = character

func getCharacter(position: int):
	if position in range(0, 5) and members.has(position):
		return members[position]
