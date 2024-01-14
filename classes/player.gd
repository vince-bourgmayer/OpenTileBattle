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
	
	var original_story: Story = Story.new("Original story", "empty_story_item_bg.webp")
	original_story.unlocked = true
	stories.append(original_story)
	
	var gs_story: Story = Story.new("Goblin Slayer: Fate's dice", "goblin_slayer_story_item_bg.webp")
	gs_story.unlocked = true
	stories.append(gs_story)

	var ff9_story: Story = Story.new("Final Fantasy 9", "ff9_story_item_bg.webp")
	stories.append(ff9_story)
	
	var terraBattle_story: Story = Story.new("Terra Battle", "terra_battle_story_item_bg.webp")
	stories.append(terraBattle_story)
