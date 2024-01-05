extends Node

const tileSideLength = 106
const tileSize = Vector2(tileSideLength, tileSideLength)
const screenSize = Vector2(720, 1280)
const maxSquadNumber = 6
const maxCharPerSquad = 6


# --- Battle Const ---
const grid_cell_separator = Vector2(2,2) # grid cell separator thickness (in two direction)
const gridOffset = Vector2(40, 250)

func get_grid_cell_for_pos(pos: Vector2):
	var formatted_position = pos-gridOffset
	return (formatted_position / Constants.tileSize).round()

# --- enum ---

enum species {WILD_BEAST, LIZARD_FOLK, STONE_FOLK, HUMAN, BEAST_FOLK, CELL, SPIRIT, MACHINE, CELESTIAL, ELF}
enum elements {NONE, FIRE, ICE, LIGHTNING, DARKNESS, SOLAR, LUNAR, GRAVITON, PHOTON, HEALING, REMEDY}
enum weapons {BOW, SPEAR, STAFF, SWORD}
enum rarities {D, C, B, A, S, SS, Z}
enum pincerType {LINE, COLUMN}
# --- Color ---

const xpBar_green = "72b868"
const lifeBar_darkBlue = "30656d"
const lifeBar_lightblue = "3dd0e4"
# --- test ---

func generateDummyFloor():
	var floor = Floor.new(1)
	floor.addPlayerFighterPos(Vector2(5,5))
	floor.addPlayerFighterPos(Vector2(1,1))
	floor.addPlayerFighterPos(Vector2(3,3))
	
	var goblinA = Foe.new("goblin spearman", 75, 12, 10, 3, 5, 3, Constants.species.WILD_BEAST, Constants.weapons.SPEAR, Constants.elements.NONE, Constants.rarities.D, "foes/goblin.webp", "", 3)
	var goblinB = Foe.new("goblin swordman", 105, 15, 14, 5, 8, 5, Constants.species.WILD_BEAST, Constants.weapons.SWORD, Constants.elements.NONE, Constants.rarities.D, "foes/goblinB.webp", "", 4)

	floor.foes[Vector2(2,1)] = goblinA
	floor.foes[Vector2(3,1)] = goblinA
	floor.foes[Vector2(4,1)] = goblinB
	floor.foes[Vector2(5,4)] = goblinB
	floor.foes[Vector2(5,3)] = goblinB
	
	return floor
