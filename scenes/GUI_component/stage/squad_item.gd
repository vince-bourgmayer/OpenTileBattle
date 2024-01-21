class_name ShortSquadItem extends Control

const containerSize = Vector2(720, 300)
var CreatureTileScene = preload("res://scenes/GUI_component/character/creature_tile.tscn")
var squad: Squad
var squadId: int

func _init(p_squad: Squad, p_squadId: int):
	squad = p_squad
	squadId = p_squadId
	

func _enter_tree():
	var container: HBoxContainer = createCharacterContainer()
	
	for n in 6:
		var characterItem : VBoxContainer = createCharacterItem(squad.getCharacter(n))
		container.add_child(characterItem)
		
	add_child(container)
	
func createCharacterContainer() -> HBoxContainer:
	var container: HBoxContainer = HBoxContainer.new()
	container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	container.custom_minimum_size = containerSize
	container.alignment = BoxContainer.ALIGNMENT_CENTER
	container.position = Vector2(0, 50)
	container.add_theme_constant_override("separation", 6)
	return container

func createCharacterItem(character: Character) -> VBoxContainer:
	var container : VBoxContainer = VBoxContainer.new()
	container.add_theme_constant_override("separation", 4)
	container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	container.size_flags_horizontal =Control.SIZE_SHRINK_CENTER
	
	var portrait = CreatureTileScene.instantiate()
	portrait.mouse_filter = Control.MOUSE_FILTER_IGNORE
	portrait.size_flags_horizontal =Control.SIZE_SHRINK_CENTER
	portrait.size_flags_vertical=Control.SIZE_SHRINK_CENTER
	
	if character == null:
		portrait.setCreature(null)
		container.add_child(portrait)
		return container
	else:
		portrait.setCreature(character.getJob())
		container.add_child(portrait)
		var nameLabel : Label = Label.new()
		nameLabel.text = character.firstname
		nameLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		nameLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		container.add_child(nameLabel)
		
		var levelLabel : Label = Label.new()
		levelLabel.text = "LvL %s" % character.getJob().level
		levelLabel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		levelLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		container.add_child(levelLabel)
		
		#TODO: add job number indicator
	return container
