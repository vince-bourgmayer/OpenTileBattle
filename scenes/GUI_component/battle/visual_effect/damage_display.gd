class_name DamageDisplayEffect extends Node2D
# Can also display heal


var label
var tweenInterval = 0.5

func _init(pos: Vector2, dmg: int, elt: Constants.elements, weap: Constants.weapons, _tween_interval = 0.3):
	label = Label.new()
	label.text = str(dmg)
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 40)
	# TODO: change text color depending on elt
	# TODO: add animated sprite depending on weapons & elt

	tweenInterval = _tween_interval
	label.visible = 0
	position = pos

	

func _enter_tree():
	#label.anchors_preset = PRESET_CENTER #TODO make it centered
	add_child(label)
	var tween = get_tree().create_tween()
	tween.tween_interval(tweenInterval)
	tween.tween_property(label, "visible", true, 0.01)
	tween.tween_property(label, "position", Vector2(label.position.x, label.position.y - 90), 0.65)
	tween.set_trans(Tween.TRANS_EXPO)

	tween.finished.connect(Callable(_on_Tween_finished))
	tween.play()


func _on_Tween_finished():
	get_parent().remove_child(self)
