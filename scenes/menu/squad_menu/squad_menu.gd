extends Control
var characterItem = preload("res://scenes/menu/squad_menu/squad_char_item.tscn")
var currentSquadNumber = 0
var currentSquad : Squad
# Called when the node enters the scene tree for the first time.

func _ready():
	$squad_nav_bar/squad_num_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	$squad_nav_bar/backButton.pressed.connect(self.prevSquad)
	$squad_nav_bar/nextButton.pressed.connect(self.nextSquad)

func _enter_tree():
	currentSquad = get_parent().player.getSquad(currentSquadNumber)
	for n in 6:
		var character_item = characterItem.instantiate()
		$squad_char_list.add_child(character_item)
		character_item.set_callbacks(_on_character_swap_button_clicked)
	updateSquadView()

func updateSquadView():
	$squad_nav_bar/squad_num_label.text = "Squad %s" % (currentSquadNumber+1)
	for n in 6:
		if currentSquad.members.has(n):
			$squad_char_list.get_child(n).setCharacter(currentSquad.getCharacter(n), n)
		else:
			$squad_char_list.get_child(n).setCharacter(null, n)

func nextSquad():
	if (currentSquadNumber == 5):
		currentSquadNumber = 0
	else:
		currentSquadNumber += 1
	currentSquad = get_parent().player.getSquad(currentSquadNumber)
	updateSquadView()

func prevSquad():
	if (currentSquadNumber == 0):
		currentSquadNumber = 5
	else:
		currentSquadNumber -= 1
	currentSquad = get_parent().player.getSquad(currentSquadNumber)
	updateSquadView()

func _on_character_swap_button_clicked(position_to_swap):
	visible = false
	var characterPickerScene = load("res://scenes/menu/character_selector_menu/character_list.tscn").instantiate()
	characterPickerScene.set_on_item_click_callback(on_swapper_choosed.bind([characterPickerScene, position_to_swap]))
	get_parent().open_character_picker()
	get_parent().add_child(characterPickerScene)


func on_swapper_choosed(character: Character, array):
	get_parent().remove_child(array[0])
	print("swap char n° %s with : %s " % [array[1], character.firstname])
	visible = true
	currentSquad.changeCharacter(array[1], character)
	updateSquadView()
