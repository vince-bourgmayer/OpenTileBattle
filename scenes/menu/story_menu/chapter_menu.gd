class_name ChapterMenu extends ScrollContainer


var story: Story
var chapter_items : Array[ChapterMenuItem] = []

func set_story(p_story: Story):
	story = p_story

func _enter_tree():
	var chapters : Array[Chapter] = story.chapters
	
	for chapter in chapters:
		var item: ChapterMenuItem = ChapterMenuItem.new(chapter, get_parent().open_stage_menu.bind(chapter))
		chapter_items.append(item)
		$chapterContainers.add_child(item)
