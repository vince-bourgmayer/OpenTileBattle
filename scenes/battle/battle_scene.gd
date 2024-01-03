extends Node2D

var stage: Stage
var currentFloor = 0
var waitingPlayer = false
var floor 
var grid_topleft 
var isPlayerTurn = false
var draggedUnit
var isDraggedUnit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	floor = Floor.new(1)
	floor.addPlayerFighterPos(Vector2(2,1))
	floor.addPlayerFighterPos(Vector2(1,1))
	floor.addPlayerFighterPos(Vector2(1,2))
	
	grid_topleft = $GUI/grid/grid.position # 40, 250
	var player  = Player.new() # test only

	generateFighterTile(player.getSquad(0).getCharacter(1).getJob(), 0)
	generateFighterTile(player.getSquad(0).getCharacter(2).getJob(), 1)
	generateFighterTile(player.getSquad(0).getCharacter(3).getJob(), 2)
	isPlayerTurn = true

func _process(_delta):
	if (isPlayerTurn == true):
		if (isDraggedUnit):
			var mousePosition = get_viewport().get_mouse_position()
			draggedUnit.position = mousePosition #getTilePos(mousePosition)


func setSquad(squad: Squad):
	pass
	

func generateFighterTile(fighter: Creature, squadOrder):
	var tile = load("res://scenes/GUI_component/character/creature_tile.tscn").instantiate()
	tile.setCreature(fighter)
	var startPos = floor.getPlayerFighterPosition(squadOrder)
	setTilePos(tile, startPos)
	print(tile.position)
	$creatures.add_child(tile)
	tile.gui_input.connect( self.onFighter_gui_input.bind(squadOrder))
	pass

func getTilePos(pos):
	var offset = grid_topleft
	var formatted_position = pos-offset
	return (formatted_position / Constants.tileSize).round()
	
func setTilePos(tile, position: Vector2):
	var realPosition = (position * Constants.tileSize) +grid_topleft
	tile.position = realPosition

func onFighter_gui_input(event: InputEvent, squadMember: int):
	if isPlayerTurn == true and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and isDraggedUnit == false:
			print("clicked on : %s" % squadMember)
			draggedUnit = $creatures.get_children()[squadMember]
			isDraggedUnit = true
			$GUI/battleTopBar/mainContainer/progressContainer/playerTimeBar.startTimer()
