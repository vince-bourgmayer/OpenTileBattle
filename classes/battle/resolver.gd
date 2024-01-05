class_name Resolver 

# class to identify pincer or chain around a character
enum direction {VERTICAL, HORIZONTAL}
var leaderA: Node2D
var leaderB: Node2D
var isPincer = false
var isChain = true
var isResolved = false
var dir: direction
var constant_axis

var pincered = []

func _init(nodeA: Node2D, nodeB: Node2D):
	var nodeA_pos = Constants.get_grid_cell_for_pos(nodeA.position)
	var nodeB_pos = Constants.get_grid_cell_for_pos(nodeB.position)
	
	if (nodeA_pos.x == nodeB_pos.x):
		dir = direction.VERTICAL
		constant_axis = nodeA_pos.x
	elif (nodeA_pos.y == nodeB_pos.y):
		dir = direction.HORIZONTAL
		constant_axis = nodeA_pos.y
		
		
	if getCoordinate(nodeA_pos) < getCoordinate(nodeB_pos):
		leaderA = nodeA
		leaderB = nodeB
	else:
		leaderA = nodeB
		leaderB = nodeA
	
	
func resolve(foes: Array):
	var A_pos = getCoordinate(Constants.get_grid_cell_for_pos(leaderA.position))
	var B_pos = getCoordinate(Constants.get_grid_cell_for_pos(leaderB.position))
	
	for foe in foes:
		var foe_pos = Constants.get_grid_cell_for_pos(foe.position)
		if isPincered(foe_pos, A_pos, B_pos):
			pincered.append(foe)
			isChain = false

	# Number of pincered unit expected is determined by end of starting pos and beginning of ending pos.
	# The pos (2,1) is the top left corner, beggining of the tile.
	if (pincered.size() == (B_pos - A_pos-1)):
		isPincer = true
		
	isResolved = true
	
func getCoordinate(node_pos : Vector2):
	if dir == direction.HORIZONTAL:
		return node_pos.x
	else:
		return node_pos.y
		
func isPincered(foe_pos: Vector2, A_pos, B_pos):
	if dir == direction.HORIZONTAL and foe_pos.y != constant_axis:
		return false
	elif dir == direction.VERTICAL and foe_pos.x != constant_axis:
		return false
		
	var foe_coordinate = getCoordinate(foe_pos)
	
	return foe_coordinate > A_pos and foe_coordinate < B_pos
