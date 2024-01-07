extends Node

const tileSideLength = 106
const tileSize = Vector2(tileSideLength, tileSideLength)
const screenSize = Vector2(720, 1280)
const maxSquadNumber = 6
const maxCharPerSquad = 6

# --- enum ---
enum species {WILD_BEAST, LIZARD_FOLK, STONE_FOLK, HUMAN, BEAST_FOLK, CELL, SPIRIT, MACHINE, CELESTIAL, ELF}
enum elements {NONE, FIRE, ICE, LIGHTNING, DARKNESS, SOLAR, LUNAR, GRAVITON, PHOTON, HEALING, REMEDY}
enum weapons {BOW, SPEAR, STAFF, SWORD}
enum rarities {D, C, B, A, S, SS, Z}
enum pincerType {LINE, COLUMN}

# --- Battle Const & func ---
const grid_cell_separator = Vector2(2,2) # grid cell separator thickness (in two direction)
const gridOffset = Vector2(40, 250)
const default_player_time = 4
func get_grid_cell_for_pos(pos: Vector2):
	
	var formatted_position = pos- Constants.tileSize/2 - gridOffset - Constants.grid_cell_separator
	return (formatted_position / Constants.tileSize).round()
	
func get_pos_from_grid_cell(cell: Vector2):
	return cell * tileSize + grid_cell_separator  + tileSize/2 + gridOffset
	
func get_random_dir():
	var result : Vector2 = Vector2.ZERO
	var random_number = randi()% 4
	match(random_number):
		0:
			result.x += 1
		1:
			result.y += 1
		2:
			result.x -= 1
		3:
			result.y -= 1
	return result
	
func compute_damage(attacker: BattleTile, defender: BattleTile):
	return attacker.atk - defender.def

# based on https://terrabattle.fandom.com/wiki/Battles
func base_physical_skill_dmg(power: int, atk: int, def: int):
	var computed_atk = pow(atk * 1.15, 1.7)
	var computed_def = pow(def, 0.7)
	return 1.1 * power * computed_atk/computed_def
	
# based on https://terrabattle.fandom.com/wiki/Battles
func base_magical_skill_dmg(power: int, mAtk: int, mDef: int):
	var computed_atk = pow(mAtk, 1.7)
	var computed_def = pow(mDef, 0.7)
	return 1.5 * power * computed_atk/computed_def

# --- Color ---
const xpBar_green = "72b868"
const lifeBar_darkBlue = "30656d"
const lifeBar_lightblue = "3dd0e4"

# --- test ---
func generateDummyStage():
	var stage = Stage.new(1, "Is he here ?")
	
	stage.add_floor(generateDummyFloor(true))
	stage.add_floor(generateDummyFloor(false))
	stage.add_floor(generateDummyFloor(false))
	
	return stage

func generateDummyFloor(isFirst: bool):
	var floor = Floor.new(1)
	var StarterPos = []
	
	if isFirst:
		StarterPos.append_array([Vector2(5,5), Vector2(1,1), Vector2(1,3)])
		floor.addPlayerFighterPos(StarterPos[0])
		floor.addPlayerFighterPos(StarterPos[1])
		floor.addPlayerFighterPos(StarterPos[2])
	
	var goblinA = Foe.new("goblin spearman", 75, 12, 10, 3, 5, 3, Constants.species.WILD_BEAST, Constants.weapons.SPEAR, Constants.elements.NONE, Constants.rarities.D, "foes/goblin.webp", "", 3)
	goblinA.xp = 150
	goblinA.coins = 20
	var goblinB = Foe.new("goblin swordman", 105, 15, 14, 5, 8, 5, Constants.species.WILD_BEAST, Constants.weapons.SWORD, Constants.elements.NONE, Constants.rarities.D, "foes/goblinB.webp", "", 4)
	goblinB.xp = 200
	goblinB.coins = 25
	var foe_number = (randi()% 11 )+4
	
	var counter = 0
	while counter < foe_number:
		var type
		if counter %2 > 0:
			type = goblinA
		else:
			type = goblinB
			
		var x = randi()%5
		var y = randi()%7
		var vector = Vector2(x, y)
		if ! StarterPos.has(vector):
			floor.foes[vector] = type
			StarterPos.append(vector)
			counter += 1
	return floor
