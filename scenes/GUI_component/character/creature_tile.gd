class_name CreatureTile extends TextureRect

func setCreature(creature: Creature):
	if (creature == null):
		clear()
	else:
		displayCreature(creature)

func displayCreature(creature: Creature):
	visibility_layer = 1
	#var texture = Texture2D.new()
	texture = load(creature.portrait_path)
	$life_bar.max_value = creature.stats.hp
	$life_bar.value = creature.stats.hp
	drawEltIcon(creature.elt)
	drawWeaponIcon(creature.weapon)

func drawWeaponIcon(weapon):
	var textureDir = "res://art/characters/icon/%s"
	match (weapon):
		0:
			$weapon_icon.texture = load(textureDir % "BowIcon.webp")
		1:
			$weapon_icon.texture = load(textureDir % "SpearIcon.webp")
		2:
			$weapon_icon.texture = load(textureDir % "StaffIcon.webp")
		3:
			$weapon_icon.texture = load(textureDir % "SwordIcon.webp")
			
func drawEltIcon(element):
	var textureDir = "res://art/characters/icon/%s"
	match (element):
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
