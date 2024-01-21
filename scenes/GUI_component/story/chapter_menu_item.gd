class_name ChapterMenuItem extends Control

const texture = {
	"normal" = preload("res://art/GUI_components/story_menu_item.webp"),
	"pressed" = preload("res://art/GUI_components/story_menu_item_clicked.webp"),
	"hover" = preload("res://art/GUI_components/story_menu_item_hover.webp"),
	"disabled" = preload("res://art/GUI_components/story_item_disabled.webp"),
	"done" = preload("res://art/GUI_components/story_menu_item_done.webp"),
	"done_hover" = preload("res://art/GUI_components/story_menu_item_done_hover.webp")
}

var button: TextureButton
var title : Label
var clicked_callback: Callable

func _init(chapter: Chapter, p_clicked_callback: Callable):
	clicked_callback = p_clicked_callback
	custom_minimum_size = Vector2(500, 75)
	build_button(chapter)
	build_title(chapter)
	var bg: TextureRect = TextureRect.new()
	bg.texture = load("res://art/story/empty_story_item_bg.webp")
	bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(bg)
	add_child(button)
	add_child(title)
	size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func build_button(chapter: Chapter):
	button = TextureButton.new()
	if chapter.alreadyDone:
		button.texture_normal = texture["done"]
		button.texture_hover = texture["done_hover"]
	else:
		button.texture_normal = texture["normal"]
		button.texture_hover = texture["hover"]
		
	button.texture_pressed = texture["pressed"]
	button.texture_disabled = texture["disabled"]
	button.disabled = !chapter.unlocked
	button.custom_minimum_size = Vector2(500, 75)
	button.pressed.connect(clicked_callback)

func build_title(chapter: Chapter):
	title = Label.new()
	title.custom_minimum_size = Vector2(500, 75)
	title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	title.add_theme_constant_override("outline_size", 8)
	title.add_theme_font_size_override("font_size", 24)
	
	var font_color : Color
	if chapter.alreadyDone:
		title.text = "Chapter %s - Achieved" % chapter.id
		font_color =  Color("16671c")
	else:
		title.text = "Chapter %s" % chapter.id
		font_color = Color("316161")
	
	title.add_theme_color_override("font_outline_color", font_color)
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE
