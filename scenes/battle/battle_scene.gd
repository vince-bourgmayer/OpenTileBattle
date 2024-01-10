extends Node2D

const foe_group = "foes"
const player_group = "player"

var clamp_start
var clamp_end

var player_tile = load("res://scenes/battle/player_tile.tscn")
var foe_tile = load("res://scenes/battle/foe_tile.tscn")
#var grid_topleft  #replaced by constants
var grid_botRight


var xp_gathered : int = 0
var coins_gathered : int = 0

var movingUnit
var isDraggedUnit = false
var movingFoeIndex = 0

var stage: Stage

enum gameState {PLAYER_MOVE, PLAYER_RESOLUTION, NPC_MOVE, NPC_RESOLUTION, PREPARATION}
var state : gameState = gameState.PREPARATION
var currentFloor = 0

var playerTile_callback = {
	"drag" : Callable(self, "on_player_dragged"),
	"drop" : Callable(self, "on_player_dropped"),
	"ally_collision" : Callable(self, "on_ally_collision")
}

var foeTile_callback = {
	"foe_death" : Callable(self, "_on_foe_death")
}

func _process(_delta):
	if (state == gameState.PLAYER_MOVE and isDraggedUnit):
		var mousePosition = get_viewport().get_mouse_position().clamp(clamp_start, clamp_end)
		movePlayerTile(_delta, movingUnit, mousePosition)
		
	elif (state == gameState.NPC_MOVE):
		if movingUnit.position == movingUnit.destination:
			movingFoeIndex += 1
			setNextMovingFoe()
		else:
			moveFoe(_delta)

# ============ Initialization =====================
func _ready():
	grid_botRight = Constants.gridOffset+ $GUI/grid/grid.size
	$GUI/battleTopBar.set_player_turn_timer_callback(Callable(self, "on_player_dropped"))
	clamp_start = Constants.gridOffset+Constants.tileSize/2
	clamp_end = grid_botRight-Constants.tileSize/2
	
func setInput(_stage : Stage, squad: Squad): # it is called before _ready()
	self.stage = _stage
	$visualEffect.add_child(BattleTitleEffect.new("Battle 1"))
	var battle_floor = stage.get_battle_floor(currentFloor)
	generate_player_tiles(squad, battle_floor)
	generate_npc_tiles(battle_floor)
	print("\n|--------PLAYER TURN--------|\n")
	state = gameState.PLAYER_MOVE
	print("state: %s" % state)

func load_next_floor():
	state = gameState.PREPARATION
	
	for foe in get_tree().get_nodes_in_group(foe_group):
		$creatures.remove_child(foe)
	
	currentFloor += 1
	
	var battle_floor : Floor= stage.get_battle_floor(currentFloor)
	if battle_floor == null:
		$visualEffect.add_child(BattleTitleEffect.new("VICTORY"))
		print("\n\n====> VICTORY <====")
		return
		
	$visualEffect.add_child(BattleTitleEffect.new("Battle %s" % (currentFloor+1)))
	for player: PlayerTile in get_tree().get_nodes_in_group(player_group):
		battle_floor.foes.erase(player.get_cell_pos())
	generate_npc_tiles(battle_floor)
	state = gameState.PLAYER_MOVE
	

func generate_player_tiles(squad: Squad, battle_floor: Floor):
	for n in Constants.maxCharPerSquad-1:
		var character = squad.getCharacter(n)
		if character == null: 
			continue
		else:
			var fighter = character.getJob()
			var tile = player_tile.instantiate()
			tile.setCreature(fighter)
			tile.set_callables(playerTile_callback)
			tile.add_to_group(player_group)
			var startPos = battle_floor.getPlayerFighterPosition(n)
			tile.position = Constants.get_pos_from_grid_cell(startPos)
			$creatures.add_child(tile)

func generate_npc_tiles(battle_floor: Floor):
	for pos in battle_floor.foes:
		var tile = foe_tile.instantiate()
		tile.setCreature(battle_floor.foes[pos])
		var startPos = pos
		tile.add_to_group(foe_group)
		tile.set_callables(foeTile_callback)
		tile.position = Constants.get_pos_from_grid_cell(startPos)
		#await get_tree().create_timer(0.5).timeout
		$creatures.add_child(tile)

# ============ Player turn  =====================

func movePlayerTile(_delta, unit: PlayerTile, destination : Vector2):
	if !isDraggedUnit:
		return
	var current_pos = unit.global_position
	var distance : float = current_pos.distance_to(destination)
	var direction: Vector2 = current_pos.direction_to(destination)
	var speed = distance/_delta
	var velocity = direction * speed
	unit.velocity = velocity
	unit.move_and_slide()

		
func on_player_dragged(playerTile: PlayerTile):
	if (state == gameState.PLAYER_MOVE and !isDraggedUnit):
		movingUnit = playerTile
		movingUnit._on_drag()
		isDraggedUnit = true
		$GUI/battleTopBar.start_player_turn_timer()
	
func on_player_dropped():
	if (isDraggedUnit):
		movingUnit._on_drop()
		isDraggedUnit = false
		$GUI/battleTopBar.finish_player_time_bar()
		resolve_playerMove()
		
		
func on_ally_collision(allyA: PlayerTile, allyB: PlayerTile):
	if movingUnit == allyA:
		print("	> %s got collision with %s" % [movingUnit.creaName, allyB.creaName])
		var movingUnit_pos = allyA.position
		var cell_pos = allyA.get_cell_pos()
		var collider_pos = allyB.get_cell_pos()
		#if (cell_pos == collider_pos):
		print("		> Collision detected on same cell %s" % cell_pos)
		var mouse_position = get_viewport().get_mouse_position()
		#var direction: Vector2 =  movingUnit.get_velocity().normalized().round() * -1
		var direction = mouse_position.direction_to(movingUnit_pos).round()
		print("direction: %s" % direction)
		#var previous_pos = allyA.get_cell_pos() + direction
		allyB.position = Constants.get_pos_from_grid_cell(collider_pos + direction).clamp(clamp_start, clamp_end)
		

func resolve_playerMove():
	state = gameState.PLAYER_RESOLUTION
	print("\n|--------PLAYER RESOLUTION--------|\n")
	var playerTiles = get_tree().get_nodes_in_group(player_group) as Array[PlayerTile]
	var foes = get_tree().get_nodes_in_group(foe_group) as Array[FoeTile]
	
	var playerResolver = PlayerResolver.new(playerTiles, foes)
	
	playerResolver.findPincers()

	for pincer in playerResolver.pincers:
		apply_pincer_damage(pincer)
		await get_tree().create_timer(1.15).timeout
	
	movingUnit = null

	if !is_some_foes_alive(foes):
		print("\n\n===> Floor completed <===\n")
		load_next_floor()
		return
	
	
	state = gameState.NPC_MOVE
	print("\n|--------FOES TURN--------|\n")
	#setNextMovingFoe()
		
	state = gameState.PLAYER_MOVE
	
func is_some_foes_alive(foes):
	for foe in foes:
		if foe.isAlive:
			return true


func apply_pincer_damage(pincer: Pincer):
	pincer.start_pincer.playAttack()
	pincer.end_pincer.playAttack()
	
	await get_tree().create_timer(0.5).timeout
	
	for ally in pincer.allies:
		ally.playAttack()
	
	for foe: FoeTile in pincer.targets:
		var tweenDelay = 0
		
		var startDmg: Damage = Constants.compute_damage(pincer.start_pincer, foe)
		var endDmg: Damage = Constants.compute_damage(pincer.end_pincer, foe)
		
		$visualEffect.add_child(DamageDisplayEffect.new(foe.position, startDmg))
		$GUI/battleTopBar.add_power(startDmg.dmg/20)
		tweenDelay += 0.55
		
		$visualEffect.add_child(DamageDisplayEffect.new(foe.position, endDmg, tweenDelay))
		$GUI/battleTopBar.add_power(endDmg.dmg/20)
		foe.applyDmg(startDmg.dmg)
		foe.applyDmg(endDmg.dmg)
		
		for ally: PlayerTile in pincer.allies:
			tweenDelay+=0.25
			var dmg: Damage = Constants.compute_damage(ally, foe)
			$visualEffect.add_child(DamageDisplayEffect.new(foe.position, dmg, tweenDelay))
			$GUI/battleTopBar.add_power(dmg.dmg/20)
			foe.applyDmg(dmg.dmg)
	
	
func _on_foe_death(foe: FoeTile):
	print("		o><  %s is dead" % foe.creaName)
	xp_gathered += foe.xp
	coins_gathered += foe.coins
	$GUI/battleTopBar.update_xp_gathered(xp_gathered)
	$GUI/battleTopBar.update_coins_gathered(coins_gathered)
# ============ NPC turn  =====================
	
func setNextMovingFoe():
	print("setNextMovingFoe")
	var foes = get_tree().get_nodes_in_group(foe_group)
	var foesCount = foes.size()
	print("foesCount = %s" % foesCount)

	while movingFoeIndex < foesCount -1:
		print("movingFoeIndex = %s" % movingFoeIndex)
		var foe = foes[movingFoeIndex]
		if !foe.isAlive:
			print("		-> is dead")
			movingFoeIndex += 1
			continue
		else:
			print("		-> start_pos: %s" % foe.position)
			foe.destination = generate_foe_destination(foe.position)
			print("		-> will move to: %s" % foe.destination)
			movingUnit = foe
			#=
			break
			
	if movingFoeIndex >= foesCount:
		print("moved ALl unit")
		state = gameState.PLAYER_MOVE
		movingFoeIndex = 0
		
func generate_foe_destination(start_position: Vector2):
	var current_pos = start_position
	var cell_pos = Constants.get_grid_cell_for_pos(current_pos)
	var cell_destination = cell_pos
	
	cell_destination += Constants.get_random_dir() * 4
	var destination = (cell_destination * Constants.tileSize + Constants.grid_cell_separator) +Constants.gridOffset
	#destination.clamp()
	return destination
		
func moveFoe(_delta):
	print("move foe")
	if movingUnit == null:
		return
	var target = movingUnit.destination
	var current_pos = movingUnit.global_position
	
	var distance : float = current_pos.distance_to(target)
	var direction: Vector2 = current_pos.direction_to(target)
	
	var speed = distance/_delta

	var velocity = direction * speed
	movingUnit.velocity = velocity
	movingUnit.move_and_slide()
