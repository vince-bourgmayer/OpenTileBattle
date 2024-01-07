class_name BattleTitleEffect extends ColorRect

var label = Label.new()
func _init(_title: String):
	set_color(Color(0,0,0,0.85))
	label.text = _title
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 70)


	
func _enter_tree():
	label.anchors_preset = PRESET_CENTER
	add_child(label)
	set_size( Vector2(label.size.x * 5, label.size.y + +20))

	anchors_preset = PRESET_CENTER

	var tween = get_tree().create_tween()
	tween.tween_interval(1)
	tween.tween_property(self, "modulate", Color(255, 255, 255, 0), 1)
	tween.set_trans(Tween.TRANS_EXPO)

	tween.finished.connect(Callable(_on_Tween_finished))
	tween.play()
	
func _on_Tween_finished():
	get_parent().remove_child(self)
