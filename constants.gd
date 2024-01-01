extends Node

const tileSideLength = 106
const tileSize = Vector2(tileSideLength, tileSideLength)
const screenSize = Vector2(720, 1280)
const maxSquadNumber = 6
const maxCharPerSquad = 6

enum species {WILD_BEAST, LIZARD_FOLK, STONE_FOLK, HUMAN, BEAST_FOLK, CELL, SPIRIT, MACHINE, CELESTIAL, ELF}
enum elements {NONE, FIRE, ICE, LIGHTNING, DARKNESS, SOLAR, LUNAR, GRAVITON, PHOTON, HEALING, REMEDY}
enum weapons {BOW, SPEAR, STAFF, SWORD}
enum rarities {D, C, B, A, S, SS, Z}



const xpBar_green = "72b868"
const lifeBar_darkBlue = "30656d"
const lifeBar_lightblue = "3dd0e4"
