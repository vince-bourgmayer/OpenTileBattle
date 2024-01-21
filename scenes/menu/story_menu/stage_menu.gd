class_name StageMenu extends VBoxContainer

var stage : Stage
var player : Player
var chapter: Chapter
var currentSquadId : int = 0

func _init():
	stage = Constants.generateDummyStage()

func set_input(p_chapter: Chapter, p_player: Player):
	chapter = p_chapter
	player = p_player

func _enter_tree():
	buildStageSelectableItems()
	$squadSelector/squadIdLabel.text = "Squad 1"
	$squadSelector/prevSquadBtn.pressed.connect(self.on_prev_squad_clicked)
	$squadSelector/nextSquadBtn.pressed.connect(self.on_next_squad_clicked)
	var squadDetail: ShortSquadItem = ShortSquadItem.new(player.getSquad(currentSquadId), currentSquadId)
	$squadDetailPlaceHolder.add_child(squadDetail)
	$startBtn.pressed.connect(start_battle)

func buildStageSelectableItems():	
	for id in chapter.stages.size():
		var button: Button = Button.new()
		button.name = str(id)
		button.text = "Stage %s" % id
		button.size_flags_horizontal =Control.SIZE_SHRINK_CENTER
		button.size = Vector2(200, 40)
		button.pressed.connect(onStageSelected.bind(chapter.stages[id]))
		$stageView/stageSelector.add_child(button)
		
func onStageSelected(p_stage : Stage):
	if $stageView.get_child_count() > 1:
		$stageView.remove_child($stageView.get_children()[1])
	var stageDetail: StageItem = StageItem.new(stage)
	$stageView.add_child(stageDetail)
	$startBtn.disabled = false


func start_battle():
	print("olez olez")
	get_parent().start_battle(stage, currentSquadId)

func on_prev_squad_clicked():
	if currentSquadId == 0 :
		currentSquadId = 5
	else:
		currentSquadId -= 1
	$squadSelector/squadIdLabel.text = "Squad %s" % str(currentSquadId + 1)
	var squadDetail: ShortSquadItem = ShortSquadItem.new(player.getSquad(currentSquadId), currentSquadId)

	$squadDetailPlaceHolder.get_child(0).free()
	$squadDetailPlaceHolder.add_child(squadDetail)

func on_next_squad_clicked():
	if currentSquadId == 5 :
		currentSquadId = 0
	else:
		currentSquadId += 1
	$squadSelector/squadIdLabel.text = "Squad %s" % str(currentSquadId + 1)
	var squadDetail: ShortSquadItem = ShortSquadItem.new(player.getSquad(currentSquadId), currentSquadId)
	$squadDetailPlaceHolder.get_child(0).free()
	$squadDetailPlaceHolder.add_child(squadDetail)
