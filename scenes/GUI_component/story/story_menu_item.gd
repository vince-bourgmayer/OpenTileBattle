class_name StoryMenuItem extends Control

var story : Story

func _set_story(p_story: Story):
	story = p_story
	$bg.texture = load(story.background)
	$title.text = story.title
	if !story.unlocked:
		$button.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
