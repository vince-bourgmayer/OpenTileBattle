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
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
		print("ipouy")
		remove_child(mainChild)
		print("youpi")
	
	
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
