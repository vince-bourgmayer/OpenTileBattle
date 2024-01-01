extends VFlowContainer

var player: Player
var char_item_node = preload("res://scenes/menu/character_selector_menu/char_list_item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	player = Player.new()
	
	for character in player.unlocked_characters:
		print("name: %s" % character.name)
		var child = char_item_node.instantiate()
		child.setCharacter(character)
		add_child(child)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass
