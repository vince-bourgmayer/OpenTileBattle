extends Node2D

const foe_group = "foes"
const player_group = "player"

var creature_tile = load("res://scenes/battle/player_tile.tscn")
#var grid_topleft  #replaced by constants
var grid_botRight

var draggedUnit
var isDraggedUnit = false

var stage: Stage
var current_floor 

enum gameState {PLAYER_MOVE, PLAYER_RESOLUTION, NPC_MOVE, NPC_RESOLUTION}
var state : gameState

var playerTile_callback = {
	"drag" : Callable(self, "on_player_dragged"),
	"drop" : Callable(self, "on_player_dropped")
}

# Called when the node enters the scene tree for the first time.
func _ready():
	state = gameState.PLAYER_MOVE
	#grid_topleft = $GUI/grid/grid.position # 40, 250
	grid_botRight = Constants.gridOffset+ $GUI/grid/grid.size
	$GUI/battleTopBar/mainContainer/progressContainer/playerTimeBar.set_timeout_callback(Callable(self, "on_player_timeout"))
	
	generateDummyFloor()
	generateFoesTile()
	
	var player  = Player.new() # test only

	generateFighterTile(player.getSquad(0).getCharacter(1).getJob(), 0)
	generateFighterTile(player.getSquad(0).getCharacter(2).getJob(), 1)
	generateFighterTile(player.getSquad(0).getCharacter(3).getJob(), 2)


func _process(_delta):
	if (state == gameState.PLAYER_MOVE):
		moveDraggedNode()

func setSquad(squad: Squad):
	pass
	

func generateFighterTile(fighter: Creature, squadOrder):
	var tile = creature_tile.instantiate()
	tile.setCreature(fighter)
	tile.set_callables(playerTile_callback)
	tile.add_to_group(player_group)
	var startPos = current_floor.getPlayerFighterPosition(squadOrder)
	
	convert_tilePos(tile, startPos)
	$creatures.add_child(tile)

func convert_tilePos(tile, position: Vector2):
	var realPosition = (position * Constants.tileSize + Constants.grid_cell_separator) +Constants.gridOffset
	tile.position = realPosition

func moveDraggedNode():
	if (isDraggedUnit):
		var mousePosition = get_viewport().get_mouse_position()
		draggedUnit.position = (mousePosition-Constants.tileSize/2).clamp(Constants.gridOffset, grid_botRight-Constants.tileSize) 
		

func on_player_dragged(playerTile):
	if (state == gameState.PLAYER_MOVE and !isDraggedUnit):
		print("dragging unit %s" % playerTile)
		draggedUnit = playerTile
		isDraggedUnit = true
		$GUI/battleTopBar/mainContainer/progressContainer/playerTimeBar.startTimer()
	
func on_player_dropped(playerTile):
	if (isDraggedUnit):
		convert_tilePos(draggedUnit, Constants.get_grid_cell_for_pos(draggedUnit.position))
		draggedUnit = null
		isDraggedUnit = false
		$GUI/battleTopBar/mainContainer/progressContainer/playerTimeBar.finish()
		resolve_playerMove()

func on_player_timeout():
		on_player_dropped(draggedUnit)


func resolve_playerMove():
	print("Resolve player action")
	state = gameState.PLAYER_RESOLUTION

	var playerTiles = get_tree().get_nodes_in_group(player_group)
	var foes = get_tree().get_nodes_in_group(foe_group)
	
	PlayerResolver.new(playerTiles, foes).findPincers()
	state = gameState.PLAYER_MOVE


func generateDummyFloor():
	current_floor = Floor.new(1)
	current_floor.addPlayerFighterPos(Vector2(5,5))
	current_floor.addPlayerFighterPos(Vector2(1,1))
	current_floor.addPlayerFighterPos(Vector2(3,3))
	
	var goblinA = Foe.new("goblin spearman", 75, 12, 10, 3, 5, 3, Constants.species.WILD_BEAST, Constants.weapons.SPEAR, Constants.elements.NONE, Constants.rarities.D, "foes/goblin.webp", "", 3)
	var goblinB = Foe.new("goblin swordman", 105, 15, 14, 5, 8, 5, Constants.species.WILD_BEAST, Constants.weapons.SWORD, Constants.elements.NONE, Constants.rarities.D, "foes/goblinB.webp", "", 4)

	current_floor.foes[Vector2(2,1)] = goblinA
	current_floor.foes[Vector2(3,1)] = goblinA
	current_floor.foes[Vector2(4,1)] = goblinA
	current_floor.foes[Vector2(5,4)] = goblinB
	current_floor.foes[Vector2(5,3)] = goblinB
	


	
func generateFoesTile():
	for pos in current_floor.foes:
		var tile = creature_tile.instantiate()
		tile.setCreature(current_floor.foes[pos])
		var startPos = pos
		tile.add_to_group(foe_group)
		convert_tilePos(tile, startPos)
		$creatures.add_child(tile)
