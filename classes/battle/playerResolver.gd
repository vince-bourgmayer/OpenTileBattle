class_name PlayerResolver

var playerUnits: Array
var foes: Array
var pincers : Array[Pincer]= []

func _init(_allies, _foes):
	playerUnits = _allies
	foes = _foes

func findPincers():
	for unit in playerUnits:
		var unit_cell = Constants.get_grid_cell_for_pos(unit.position)
		
		print("Look for pincer with %s" % unit_cell)
		var unit_allies = []
		var unit_pincers : Array[Pincer]= []

		for ally in playerUnits:
			if ally == unit or isPincerAlreaadyknown(unit, ally, pincers):
				print("	--> ignored")
				continue
				
			var ally_cell = Constants.get_grid_cell_for_pos(ally.position)
			if (!isUnitsAligned(unit_cell, ally_cell)):
				print("	--> is not aligned")
				continue
			print("	--> candidate_cell: %s" % ally_cell)
			
			var resolver = Resolver.new(unit, ally)
			resolver.resolve(foes)
			
			if resolver.isPincer:
				var pincer = Pincer.new(resolver.leaderA, resolver.leaderB, resolver.type)
				pincer.targets = resolver.pincered
				unit_pincers.append(pincer)
				
			elif resolver.isChain:
				unit_allies.append(ally)
					
		for pincer in unit_pincers:
			pincer.allies.append_array(unit_allies)
			pincers.append(pincer)

	print("pincer founds: %s" % pincers.size())
	
func isPincerAlreaadyknown(playerA, playerB, pincers: Array[Pincer]):
	for item in pincers:
		if item.isFor(playerA, playerB):
			return true
	return false

func isUnitsAligned(A_pos, B_pos):
	return A_pos.x == B_pos.x or A_pos.y == B_pos.y
	
	
