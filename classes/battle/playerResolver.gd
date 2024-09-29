class_name PlayerResolver

var playerUnits: Array
var foes: Array
var pincers : Array[Pincer]= []
var print_debug = false

func _init(_allies, _foes):
	playerUnits = _allies
	foes = _foes

func findPincers():
	for unit: PlayerTile in playerUnits:
		var unit_cell = Constants.get_grid_cell_for_pos(unit.position)
		var unit_allies = []
		var unit_pincers : Array[Pincer]= []
				
		printLog("Look for pincer with %s at %s" % [unit.creaName, unit_cell])
		
		for ally: PlayerTile in playerUnits:
			if ally == unit or isPincerAlreaadyknown(unit, ally):
				printLog("	--> ignored %s" % ally.creaName)
				continue
				
			var ally_cell = Constants.get_grid_cell_for_pos(ally.position)
			if (!isUnitsAligned(unit_cell, ally_cell)):
				printLog("	--> %s is not aligned" % ally.creaName)
				continue
				
			printLog("	--> candidate_cell: %s at %s" % [ally.creaName, ally_cell])
			
			var resolver = Resolver.new(unit, ally)
			resolver.resolve(foes)
			
			if resolver.isPincer:
				var pincer = Pincer.new(resolver.leaderA, resolver.leaderB, resolver.type)
				pincer.targets = resolver.pincered
				unit_pincers.append(pincer)
				printLog("	--> Added pincers with %s" % ally.creaName)
				
			elif resolver.isChain:
				for pincer: Pincer in pincers:
					if pincer.has(unit):
						pincer.add_ally(ally)
				unit_allies.append(ally)

					
		for pincer: Pincer in unit_pincers:
			pincer.allies.append_array(unit_allies)
			pincers.append(pincer)

	print("pincer founds: %s" % pincers.size())
	
func isPincerAlreaadyknown(playerA: PlayerTile, playerB: PlayerTile):
	for item: Pincer in pincers:
		if item.isFor(playerA, playerB):
			return true
	return false

func isUnitsAligned(A_pos: Vector2, B_pos: Vector2):
	return A_pos.x == B_pos.x or A_pos.y == B_pos.y
	
func printLog(msg: String):
	if print_debug:
		print(msg)
