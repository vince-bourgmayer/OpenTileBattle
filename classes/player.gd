class_name Player extends Resource

@export var coins : int = 0
@export var squads : Array[Squad]
@export var unlocked_characters: CharactersList
#@export var isNewPlayer = false

func _init():
	buildSquad()
	unlocked_characters = CharactersList.new()
	unlocked_characters.generate_test_characters() # for test purposes

func buildSquad():
	squads = []
	for n in 6:
		squads.append(Squad.new(n))

func getSquad(squadId: int):
	if squadId in range (0, 6):
		return squads[squadId]
		
