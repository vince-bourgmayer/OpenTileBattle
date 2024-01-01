extends Node2D

@export var player_tile_scene : PackedScene
var gridSize = Vector2(639, 852) # grid texture size
var gridPos = Vector2(360, 750) # position of center of the grid in the UI
var grid_topLeft = Vector2.ZERO
var grid_bottomRight = Vector2.ZERO
var gridBorder_width = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	grid_topLeft = Vector2(gridPos.x-(gridSize.x/2)+gridBorder_width, gridPos.y-(gridSize.y/2)+gridBorder_width)
	grid_bottomRight = Vector2(gridPos.x+(gridSize.x/2)-gridBorder_width, gridPos.y+(gridSize.y/2)-gridBorder_width)

	var character_1 = player_tile_scene.instantiate()
	var char_1_pos = Vector2(5,3)
	var char1_tex = "res://art/characters/samatha/Samatha_job2_icon.webp"
	character_1.defineChar("Sam", 1)
	character_1.start(grid_topLeft, grid_bottomRight, char_1_pos, char1_tex)
	add_child(character_1)


	var character_2 = player_tile_scene.instantiate()
	var char_2_pos = Vector2(1,1)
	character_2.defineChar("Atha", 2)
	var char2_tex = "res://art/characters/samatha/Samatha_job1_icon.webp"
	
	character_2.start(grid_topLeft, grid_bottomRight, char_2_pos, char2_tex)
	add_child(character_2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
