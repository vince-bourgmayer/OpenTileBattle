extends Control
enum menu {NONE, STORY, SQUAD, TAVERN, ITEMS}
# main
var menu_item_scene = load("res://scenes/menu/main_menu_item/main_menu_item.tscn") as PackedScene
var mainChild

var currentMenu_displayed : menu = menu.NONE
var player = Player.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	init_nav_bar()

func init_nav_bar():
	var storyItem = menu_item_scene.instantiate()
	storyItem.text = "Story"
	storyItem.icon = preload("res://art/bookIcon.webp")
	storyItem.pressed.connect(self.openStoryMenu)

	$navBar.add_child(storyItem)
	
	var squadItem = menu_item_scene.instantiate()
	squadItem.text = "Squad"
	squadItem.icon = preload("res://art/Recode_DNA_icon.webp")
	squadItem.pressed.connect(self.openSquadMenu)
	$navBar.add_child(squadItem)
	
	var tavernItem = menu_item_scene.instantiate()
	tavernItem.text = "Tavern"
	tavernItem.icon = preload("res://art/Metal_Ticket.webp")
	tavernItem.pressed.connect(self.openTavernMenu)
	$navBar.add_child(tavernItem)
	
	var chestItem = menu_item_scene.instantiate()
	chestItem.text = "Items"
	chestItem.icon = preload("res://art/Metal_Ticket.webp")
	$navBar.add_child(chestItem)
	pass
	

func openStoryMenu():
	if (currentMenu_displayed == menu.STORY):
		print("ignore Story menu opening")
		return
	else:
		currentMenu_displayed = menu.STORY
		self.remove_child(mainChild)
		self.remove_child($navBar)
		mainChild = load("res://scenes/battle/battle_scene.tscn").instantiate()
		var stage = Constants.generateDummyStage()
		mainChild.setInput(stage, player.getSquad(1))
		self.add_child(mainChild)
	
	
func openSquadMenu():
	if (currentMenu_displayed == menu.SQUAD):
		print("ignore squad menu opening")
		return
	else:
		currentMenu_displayed = menu.SQUAD
		self.remove_child(mainChild)
		mainChild = load("res://scenes/menu/squad_menu/squad_menu.tscn").instantiate()
		self.add_child(mainChild)
		
		
func openTavernMenu():
	if (currentMenu_displayed == menu.TAVERN):
		print("ignore TAVERN menu opening")
		return
	else:
		currentMenu_displayed = menu.TAVERN
		self.remove_child(mainChild)
		mainChild = load("res://scenes/menu/character_selector_menu/character_list.tscn").instantiate()
		self.add_child(mainChild)

#func export_characters_data():
	#const character_data_list_path = "res://gameData/characters_data.tres"
	#
	#var high_elf_job = Job.new("the Archer", CreatureStats.new(420, 53, 50, 21, 30), 1, Constants.species.ELF, Constants.weapons.BOW, 0, Constants.rarities.SS, "characters/high_elf/high_elf_job1_icon.webp", "", 0.0, true)
	#var high_elf = Character.new("High elf", [high_elf_job], 0)
	#
	#var goblinSlayer_job = Job.new("as swordman", CreatureStats.new(1027, 94, 98, 50, 45), 1, Constants.species.HUMAN, Constants.weapons.SWORD, 0, Constants.rarities.S, "characters/goblin_slayer/goblin_slayer_job1_icon.webp", "", 0.4, true)
	#var goblin_slayer = Character.new("Goblin Slayer", [goblinSlayer_job], 0)
	##characters.append(high_elf)
	##characters.append(goblin_slayer)
	#
	#var result = ResourceSaver.save(high_elf, character_data_list_path)
	#assert(result == OK)
