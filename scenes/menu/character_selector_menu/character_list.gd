extends ScrollContainer

var char_item_node = preload("res://scenes/menu/character_selector_menu/char_list_item.tscn")

var on_item_click_callBack: Callable
# Called when the node enters the scene tree for the first time.
func _ready():
	for character: Character in get_parent().player.unlocked_characters:
		print("name: %s" % character.firstname)
		var child = char_item_node.instantiate()
		child.setCharacter(character)
		$character_list.add_child(child)
		child.set_callback(on_item_click_callBack)

func set_on_item_click_callback(callback: Callable):
	on_item_click_callBack = callback
