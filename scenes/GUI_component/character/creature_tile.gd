extends TextureRect
signal icon_clicked

var creature : Creature
var isDisplayed = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (creature == null):
		clear()
	elif (isDisplayed == false):
		displayCreature()
	pass


func setCreature(creature: Creature):
	self.creature = creature
	isDisplayed = false

func displayCreature():
	visibility_layer = 1
	#var texture = Texture2D.new()
	texture = load(creature.portrait_path)
	$life_bar.value = creature.hp
	$life_bar.max_value = creature.maxHP
	drawEltIcon()
	drawWeaponIcon()
	isDisplayed = true

func drawWeaponIcon():
	var textureDir = "res://art/characters/icon/%s"
	match (creature.weapon):
		0:
			$weapon_icon.texture = load(textureDir % "BowIcon.webp")
		1:
			$weapon_icon.texture = load(textureDir % "SpearIcon.webp")
		2:
			$weapon_icon.texture = load(textureDir % "StaffIcon.webp")
		3:
			$weapon_icon.texture = load(textureDir % "SwordIcon.webp")
			
func drawEltIcon():
	var textureDir = "res://art/characters/icon/%s"
	match (creature.elt):
		0:
			$elt_icon.texture = null
		1:
			$elt_icon.texture = load(textureDir % "fire_triangle.png")
		2:
			$elt_icon.texture = load(textureDir % "ice_triangle.png")
		3:
			$elt_icon.texture = load(textureDir % "lightning_triangle.png")
		4:
			$elt_icon.texture = load(textureDir % "darkness_triangle.png")
			
func clear():
	visibility_layer = 0
	isDisplayed = false


func _on_gui_input(event):
	if (event is InputEventMouseButton and event.pressed):
		icon_clicked.emit()
	pass # Replace with function body.
