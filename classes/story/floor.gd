class_name Floor extends Resource

@export var id: int # Floor number in the stage
@export var foes : Dictionary = {} # vector 2 position associated to a foe entry
@export var playerFighterPos: Array[Vector2] = [] # to remove it is stored in the stage Object
# var traps

func _init(floorId: int):
	id = floorId

func addPlayerFighterPos(position: Vector2):
	if (playerFighterPos.size() < 6):
		playerFighterPos.append(position)


func getPlayerFighterPosition(squadOrder: int): #squad order is position of player's creature in the squad
	if (squadOrder < 6):
		return playerFighterPos[squadOrder]
	else:
		return null
