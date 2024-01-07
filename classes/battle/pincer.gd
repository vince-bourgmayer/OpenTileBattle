class_name Pincer


var targets = [] # foes
var allies = [] # allies allowed to support
var type : Constants.pincerType
var start_pincer
var end_pincer

func _init(pincerA, pincerB, pincerType):
	start_pincer = pincerA
	end_pincer = pincerB
	type = pincerType
	
func add_target(target):
	targets.append(target)
	
func add_ally(ally):
	allies.append(ally)

func isFor(nodeA, nodeB):
	if (start_pincer == nodeA and end_pincer == nodeB):
		return true
	elif (start_pincer == nodeB and end_pincer == nodeA):
		return true
	else: 
		return false
		
func has(tile: PlayerTile):
	if start_pincer == tile or end_pincer == tile:
		return true
