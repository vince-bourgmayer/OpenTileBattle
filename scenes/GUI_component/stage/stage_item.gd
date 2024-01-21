class_name StageItem extends VBoxContainer

var stage: Stage

func _init(p_stage: Stage):
	stage = p_stage
	
func _enter_tree():
	add_child(buildTitleLabel())
	add_child(buildFloorCountLabel())
	var foesTypeLabel: Label = Label.new()
	foesTypeLabel.text = "Foes' type:"
	foesTypeLabel.add_theme_font_size_override("font_size", 20)
	
	add_child(foesTypeLabel)
	add_child(buildElementalDetails())
	
	add_child(buildWeaponsDetail())
	
	print("stage added")


func buildTitleLabel() -> Label:
	var label : Label = Label.new()
	label.text = stage.title
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 30)
	return label

func buildFloorCountLabel() -> Label:
	var label : Label = Label.new()
	label.add_theme_font_size_override("font_size", 20)
	label.text = "Battle floors: %s" % stage.battle_foors.size()
	return label


func buildElementalDetails() -> HFlowContainer:
	var container : HFlowContainer = HFlowContainer.new()
	container.add_theme_constant_override("h_separation", 15)
	container.add_theme_constant_override("v_separation", 2.5)
	
	var foesEltCount : Dictionary = count_enemy_by_elt()
	for elt in foesEltCount:
		var counter = foesEltCount[elt]
		
		var amountLabel : Label = Label.new()
		amountLabel.text = str(counter)
		amountLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		if counter < 10:
			amountLabel.custom_minimum_size = Vector2(46, 35)
		else:
			amountLabel.custom_minimum_size = Vector2(55, 35)
		amountLabel.add_theme_font_size_override("font_size", 25)
		
		var eltIcon : TextureRect = TextureRect.new()
		var texturePath = "res://art/characters/icon/%s_triangle.png"
		var eltName : String = Constants.elements.keys()[elt].to_lower()
		print(texturePath % eltName)
		eltIcon.texture = load(texturePath % eltName)
		eltIcon.position = Vector2(0, 5)
		amountLabel.add_child(eltIcon)
		container.add_child(amountLabel)
		
	return container

func count_enemy_by_elt() -> Dictionary:
	var dic : Dictionary = {}
	for floorItem : Floor in stage.battle_foors:
		for foe : Foe in floorItem.foes.values():
			if foe.elt == Constants.elements.NONE or foe.elt == Constants.elements.NEUTRAL:
				continue
			if dic.has(foe.elt):
				dic[foe.elt] += 1
			else:
				dic[foe.elt] = 1
	return dic
	
	
func buildWeaponsDetail() -> HFlowContainer:
	var container: HFlowContainer = HFlowContainer.new()
	container.add_theme_constant_override("h_separation", 15)
	container.add_theme_constant_override("v_separation", 2.5)
	var weaponDic : Dictionary = count_enemy_by_weapon()
	
	for item in weaponDic:
		var counter = weaponDic[item]
		
		var amountLabel : Label = Label.new()
		amountLabel.text = str(counter)
		amountLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		if counter < 10:
			amountLabel.custom_minimum_size = Vector2(42, 35)
		else:
			amountLabel.custom_minimum_size = Vector2(55, 35)
		amountLabel.add_theme_font_size_override("font_size", 23)
		
		var weaponIcon : TextureRect = TextureRect.new()
		var texturePath = "res://art/characters/icon/%sIcon.webp"
		var weaponName : String = Constants.weapons.keys()[item].to_lower().capitalize()
		print(texturePath % weaponName)
		weaponIcon.texture = load(texturePath % weaponName)
		weaponIcon.position = Vector2(0, 5)
		amountLabel.add_child(weaponIcon)
		container.add_child(amountLabel)
		
	return container
	
func count_enemy_by_weapon() -> Dictionary:
	var dic : Dictionary = {}
	for floorItem : Floor in stage.battle_foors:
		for foe : Foe in floorItem.foes.values():
			if dic.has(foe.weapon):
				dic[foe.weapon] += 1
			else:
				dic[foe.weapon] = 1
	return dic
