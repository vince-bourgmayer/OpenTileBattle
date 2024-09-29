class_name StoryMenuItem extends Control

var story : Story
var clicked_callback: Callable

func _set_story(p_story: Story):
	story = p_story
	$bg.texture = load(story.background)
	$title.text = story.title
	if !story.unlocked:
		$button.disabled = true
	$button.pressed.connect(clicked_callback)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
