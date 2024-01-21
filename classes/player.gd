class_name Player extends Resource

@export var coins : int = 0
@export var squads : Array[Squad]
@export var unlocked_characters: CharactersList
@export var stories : Array[Story] = []

#@export var isNewPlayer = false

func _init():
	buildSquad()
	unlocked_characters = CharactersList.new()
	unlocked_characters.generate_test_characters() # for test purposes
	_generate_test_stories()

func buildSquad():
	squads = []
	for n in 6:
		squads.append(Squad.new(n))

func getSquad(squadId: int):
	if squadId in range (0, 6):
		return squads[squadId]
		

func _generate_test_stories():
	
	var original_story: Story = Story.new("Introduction", "empty_story_item_bg.webp")
	original_story.unlocked = true

	
	var intro_chapter_1 = Chapter.new(1)
	intro_chapter_1.alreadyDone = true
	intro_chapter_1.unlocked = true
	
	var intro_chapter_2 = Chapter.new(2)
	intro_chapter_2.alreadyDone = true
	intro_chapter_2.unlocked = true
	
	var intro_chapter_3 = Chapter.new(3)
	intro_chapter_3.alreadyDone = true
	intro_chapter_3.unlocked = true
	
	original_story.chapters.append_array([intro_chapter_1, intro_chapter_2, intro_chapter_3])
	stories.append(original_story)
	
	var gs_story: Story = Story.new("Goblin Slayer: Fate's dice", "goblin_slayer_story_item_bg.webp")
	gs_story.unlocked = true
	
	var gs_chapter_1 = Chapter.new(1)
	gs_chapter_1.alreadyDone = true
	gs_chapter_1.unlocked = true
	
	var gs_chap1_stage_0 : Stage = Constants.generateDummyStage()
	gs_chap1_stage_0.title = "I can smell goblins here"
	var gs_chap1_stage_1 : Stage= Constants.generateDummyStage()
	gs_chap1_stage_1.title =  "It's a Goblin's Nest"
	gs_chapter_1.stages.append(gs_chap1_stage_0)
	gs_chapter_1.stages.append(gs_chap1_stage_1)
	
	var gs_chapter_2 = Chapter.new(2)
	gs_chapter_2.unlocked = true
	gs_chapter_2.stages.append(Constants.generateDummyStage())
	gs_chapter_2.stages.append(Constants.generateDummyStage())
	gs_chapter_2.stages.append(Constants.generateDummyStage())
	
	
	var gs_chapter_3 = Chapter.new(3)
	var gs_chapter_4 = Chapter.new(4)
	var gs_chapter_5 = Chapter.new(5)
	
	gs_story.chapters.append_array([gs_chapter_1, gs_chapter_2, gs_chapter_3, gs_chapter_4, gs_chapter_5])
	stories.append(gs_story)

	var ff9_story: Story = Story.new("Final Fantasy 9", "ff9_story_item_bg.webp")
	stories.append(ff9_story)
	
	var terraBattle_story: Story = Story.new("Terra Battle", "terra_battle_story_item_bg.webp")
	stories.append(terraBattle_story)
