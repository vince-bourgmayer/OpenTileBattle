extends Node

const tileSideLength = 106
const tileSize = Vector2(tileSideLength, tileSideLength)
const screenSize = Vector2(720, 1280)
const maxSquadNumber = 6
const maxCharPerSquad = 6

# --- enum ---
enum species {WILD_BEAST, LIZARD_FOLK, STONE_FOLK, HUMAN, BEAST_FOLK, CELL, SPIRIT, MACHINE, CELESTIAL, ELF}
enum elements {NONE, FIRE, ICE, LIGHTNING, DARKNESS, SOLAR, LUNAR, GRAVITON, PHOTON, HEALING, REMEDY, NEUTRAL}
enum weapons {BOW, SPEAR, STAFF, SWORD}
enum rarities {D, C, B, A, S, SS, Z}
enum pincerType {LINE, COLUMN}

# enum ---> skills
enum skill_tiers {NONE = -1, TIER_1 =0, TIER_2 =1, TIER_3 =2, TIER_4 = 3}
enum skill_targets {SELF, EQUIP, LATERAL, VERTICAL, ALL, CHAIN, AREA, COLUMN, LINE, CROSS, COUNTER, PINCER }
enum skill_effect_type {HEAL, CURE, BUFF, HIT}

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
	var weapon_carnage_bonus = get_weapon_carnage_bonus(attacker.weapon, defender.weapon)
	var dmg = base_physical_skill_dmg(0.7, attacker.atk, defender.def) * weapon_carnage_bonus
	return Damage.new(dmg, attacker.elt, attacker.weapon)


# based on https://terrabattle.fandom.com/wiki/Battles
func base_physical_skill_dmg(power: float, atk: int, def: int):
	var computed_atk = pow(atk * 1.15, 1.7)
	var computed_def = pow(def, 0.7)
	return 1.1 * power * computed_atk/computed_def
	
# based on https://terrabattle.fandom.com/wiki/Battles
func base_magical_skill_dmg(power: int, mAtk: int, mDef: int):
	var computed_atk = pow(mAtk, 1.7)
	var computed_def = pow(mDef, 0.7)
	return 1.5 * power * computed_atk/computed_def
	
func get_weapon_carnage_bonus(atk_weapon: weapons, def_weapon: weapons):
	var sword_on_bow = atk_weapon == weapons.SWORD and def_weapon == weapons.BOW
	var spear_on_sword = atk_weapon == weapons.SPEAR and def_weapon == weapons.SWORD
	var bow_on_spear = atk_weapon == weapons.BOW and def_weapon == weapons.SPEAR
	if sword_on_bow or spear_on_sword or bow_on_spear:
		return 2
	else:
		return 1
	

# --- Color ---
const xpBar_green = "72b868"
const lifeBar_darkBlue = "30656d"
const lifeBar_lightblue = "3dd0e4"

# --- test ---
func generateDummyStage() -> Stage:
	var stage = Stage.new(1, "Is he here ?")
	
	var nb =  (randi()% 3 )+1
	for n in nb:
		stage.add_floor(generateDummyFloor(true))
	
	return stage

func generateDummyFloor(isFirst: bool) -> Floor:
	var floor = Floor.new(1)
	var StarterPos = []
	
	if isFirst:
		StarterPos.append_array([Vector2(5,5), Vector2(1,1), Vector2(1,3),Vector2(0,0),Vector2(0,4),Vector2(5,7)])
		floor.addPlayerFighterPos(StarterPos[0])
		floor.addPlayerFighterPos(StarterPos[1])
		floor.addPlayerFighterPos(StarterPos[2])
		floor.addPlayerFighterPos(StarterPos[3])
		floor.addPlayerFighterPos(StarterPos[4])
		floor.addPlayerFighterPos(StarterPos[5])
	var goblinA_stats = CreatureStats.new(75, 12, 10, 3, 5)
	var goblinA = Foe.new("goblin spearman", goblinA_stats, 3, Constants.species.WILD_BEAST, Constants.weapons.SPEAR, Constants.elements.NONE, Constants.rarities.D, "foes/goblin.webp", "", 3)
	goblinA.xp = 150
	goblinA.coins = 20
	var goblinB_stats = CreatureStats.new(105, 15, 14, 5, 8)
	var goblinB = Foe.new("goblin swordman", goblinB_stats, 5, Constants.species.WILD_BEAST, Constants.weapons.SWORD, Constants.elements.NONE, Constants.rarities.D, "foes/goblinB.webp", "", 4)
	goblinB.xp = 200
	goblinB.coins = 25
	
	
	var fireGoblin_stats = CreatureStats.new(450, 34, 20, 25, 12)
	var fireGoblin = Foe.new("Fire Goblin", fireGoblin_stats, 7, Constants.species.WILD_BEAST, Constants.weapons.STAFF, Constants.elements.FIRE, Constants.rarities.C, "foes/goblinB.webp", "", 4)
	fireGoblin.xp = 300
	fireGoblin.coins = 45
	
	var pirateGolbin_stats = CreatureStats.new(375, 30, 21, 14, 10)
	var pirateGoblin = Foe.new("Pirate Goblin", fireGoblin_stats, 5, Constants.species.WILD_BEAST, Constants.weapons.BOW, Constants.elements.ICE, Constants.rarities.C, "foes/goblinA.webp", "", 4)
	pirateGoblin.xp = 245
	pirateGoblin.coins = 75
	
	var foe_number = (randi()% 13 )+4
	
	var counter = 0
	while counter < foe_number:
		var type
		if counter %7 == 0:
			type = fireGoblin
		elif counter %11 == 0:
			type = pirateGoblin
		elif counter %2 > 0:
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
