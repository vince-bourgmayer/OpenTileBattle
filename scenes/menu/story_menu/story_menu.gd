class_name StoryMenu extends ScrollContainer

var story_item = preload("res://scenes/GUI_component/story/story_menu_item.tscn")
var stories: Array[Story]
var story_items: Array[PackedScene]

func _enter_tree():
	stories = get_parent().player.stories
	
	for story in stories:
		var item: StoryMenuItem = story_item.instantiate()
		item._set_story(story)
		story_items.append(item)
		$storiesContainer.add_child(item)


func _ready():
	print("YAHOO")
