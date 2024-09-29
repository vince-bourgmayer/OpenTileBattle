class_name DamageDisplayEffect extends Node2D
# Can also display heal

var label
var tweenInterval = 0.5
var hit_texture: TextureRect

func _init(pos: Vector2, dmg: Damage, _tween_interval = 0.3):
	label = Label.new()
	label.text = str(dmg.dmg)
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 40)
	# TODO: change text color depending on elt
	# TODO: add animated sprite depending on weapons & elt

	match (dmg.element):
		Constants.elements.LIGHTNING:
			label.add_theme_color_override("font_color", Color.YELLOW)
		Constants.elements.DARKNESS:
			label.add_theme_color_override("font_color", Color.REBECCA_PURPLE)
		Constants.elements.FIRE:
			label.add_theme_color_override("font_color", Color.FIREBRICK)
		Constants.elements.ICE:
			label.add_theme_color_override("font_color", Color.DEEP_SKY_BLUE)
			
	hit_texture = TextureRect.new()
	hit_texture.texture = load("res://art/battle/hit_effect.webp")
	
	tweenInterval = _tween_interval
	label.visible = 0
	position = pos

	

func _enter_tree():
	#label.anchors_preset = PRESET_CENTER #TODO make it centered
	add_child(label)
	add_child(hit_texture)
	label.position -= Constants.tileSize/2
	hit_texture.position -= Constants.tileSize/2
	hit_texture.visible = false
	var transparency=hit_texture.modulate
	transparency.a = 0
	
	var tween = get_tree().create_tween()
	tween.tween_interval(0.2)
	tween.tween_property(hit_texture, "visible", true, 0.01)
	tween.tween_property(hit_texture, "modulate", transparency, 0.08)
	tween.tween_interval(tweenInterval)
	tween.tween_property(label, "visible", true, 0.01)

	tween.tween_property(label, "position", Vector2(label.position.x, label.position.y - 90), 0.65)

	tween.set_trans(Tween.TRANS_EXPO)

	tween.finished.connect(Callable(_on_Tween_finished))
	tween.play()


func _on_Tween_finished():
	get_parent().remove_child(self)
