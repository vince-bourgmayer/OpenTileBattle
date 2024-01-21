class_name StageMenu extends VBoxContainer

var stage : Stage
var player : Player

var chapter: Chapter

func _init():
	stage = Constants.generateDummyStage()
	stage.title = "A test stage in the mist"
	
func set_input(p_chapter: Chapter, p_player: Player):
	chapter = p_chapter
	player = p_player

func _enter_tree():
	buildStageSelectableItems()
	
	var squadDetail: ShortSquadItem = ShortSquadItem.new(player.getSquad(0), 0)
	$squadDetailPlaceHolder.add_child(squadDetail)


func buildStageSelectableItems():
	
	for id in chapter.stages.size():
		var button: Button = Button.new()
		button.name = str(id)
		button.text = "Stage %s" % id
		button.size = Vector2(200, 40)
		button.size_flags_horizontal =Control.SIZE_SHRINK_CENTER
		button.pressed.connect(onStageSelected.bind(chapter.stages[id]))
		$stageView/stageSelector.add_child(button)
		
func onStageSelected(stage : Stage):
	if $stageView.get_child_count() > 1:
		$stageView.remove_child($stageView.get_children()[1])
	var stageDetail: StageItem = StageItem.new(stage)
	$stageView.add_child(stageDetail)
		
