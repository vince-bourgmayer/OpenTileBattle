extends Node2D

const foe_group = "foes"
const player_group = "player"

var player_tile = load("res://scenes/battle/player_tile.tscn")
var foe_tile = load("res://scenes/battle/foe_tile.tscn")
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
	
	current_floor = Constants.generateDummyFloor()
	generateFoesTile()
	
	var player  = Player.new() # test only

	generateFighterTile(player.getSquad(0).getCharacter(1).getJob(), 0)
	generateFighterTile(player.getSquad(0).getCharacter(2).getJob(), 1)
	generateFighterTile(player.getSquad(0).getCharacter(3).getJob(), 2)


func _process(_delta):
	if (state == gameState.PLAYER_MOVE and isDraggedUnit):
		moveDraggedNode(_delta)

#func setSquad(squad: Squad):
#	pass

func generateFighterTile(fighter: Creature, squadOrder):
	var tile = player_tile.instantiate()
	tile.setCreature(fighter)
	tile.set_callables(playerTile_callback)
	tile.add_to_group(player_group)
	var startPos = current_floor.getPlayerFighterPosition(squadOrder)
	
	convert_tilePos(tile, startPos)
	$creatures.add_child(tile)

func convert_tilePos(tile, position: Vector2):
	var realPosition = (position * Constants.tileSize + Constants.grid_cell_separator) +Constants.gridOffset
	tile.position = realPosition

func moveDraggedNode(_delta):
	if (isDraggedUnit):
		var mousePosition = get_viewport().get_mouse_position().clamp(Constants.gridOffset, grid_botRight-Constants.tileSize) 
		var current_pos = draggedUnit.global_position
		
		var distance : float = current_pos.distance_to(mousePosition)
		var direction: Vector2 = current_pos.direction_to(mousePosition)
		
		var speed = distance/_delta


		var velocity = direction * speed
		draggedUnit.velocity = velocity
		draggedUnit.move_and_slide()

		

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
	
	var playerResolver = PlayerResolver.new(playerTiles, foes)
	
	playerResolver.findPincers()

	for pincer in playerResolver.pincers:
		applyDamage(pincer)
		
	state = gameState.NPC_MOVE
	
		
func applyDamage(pincer: Pincer):
	pincer.start_pincer.playAttack()
	pincer.end_pincer.playAttack()
	
	for foe in pincer.targets:
		var startDmg= computeDamage(pincer.start_pincer, foe)
		foe.applyDmg(startDmg)
		$GUI/battleTopBar/mainContainer/progressContainer/power_bar.addPower(startDmg/25)
		var endDmg = computeDamage(pincer.end_pincer, foe)
		foe.applyDmg(endDmg)
		$GUI/battleTopBar/mainContainer/progressContainer/power_bar.addPower(endDmg/25)
		
		if (!foe.isAlive):
			foe.playDeath()

func computeDamage(src, target):
	return src.atk - target.def
	
func generateFoesTile():
	for pos in current_floor.foes:
		var tile = foe_tile.instantiate()
		tile.setCreature(current_floor.foes[pos])
		var startPos = pos
		tile.add_to_group(foe_group)
		convert_tilePos(tile, startPos)
		$creatures.add_child(tile)
