class_name StageView extends VSplitContainer

var stage : Stage
var player : Player = Player.new()

func _init():
	stage = Constants.generateDummyStage()
	stage.title = "A test stage in the mist"
	
	
	player.squads[0].changeCharacter(0, player.unlocked_characters.characters[3])
	player.squads[0].changeCharacter(1, player.unlocked_characters.characters[6])
	player.squads[0].changeCharacter(2, player.unlocked_characters.characters[5])
	player.squads[0].changeCharacter(3, player.unlocked_characters.characters[4])

func _enter_tree():
	print("enter_tree")
	var stageDetail: StageItem = StageItem.new(stage)
	add_child(stageDetail)
	
	var squadDetail: ShortSquadItem = ShortSquadItem.new(player.getSquad(0), 0)
	add_child(squadDetail)
