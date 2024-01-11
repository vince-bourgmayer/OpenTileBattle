class_name Squad extends Resource

@export var id : int
@export var members: Dictionary = Dictionary()

func _init(squadId: int):
	id = squadId
	
func changeCharacter(position: int, character: Character):
	if (position == 5):
		print("hey hohoooo")
	if position in range(0, 6):
		members[position] = character

func getCharacter(position: int):
	if position in range(0, 6) and members.has(position):
		return members[position]
