#extends StaticBody2D
class_name PlayerTile extends BattleTile

# Called when the node enters the scene tree for the first time.

var SkillBoost = 0.0
var size: Vector2

var isDragged = false
var previous_cell: Vector2
var last_known_cell: Vector2

func _ready():
	size = $button.size

func _process(_delta):
	if isDragged:
		var current_cell = get_cell_pos()
		if (last_known_cell != current_cell):
			previous_cell = last_known_cell # it works only because previous_cell & last_known_cell are initialized with same value
			last_known_cell = current_cell
		

func disable(val):
	$button.disabled = val
	
func setCreature(creature: Creature):
	super.setCreature(creature)
	$icon.setCreature(creature)
	SkillBoost = creature.skillBoost
	
func applyDmg(dmg):
	if !isAlive:
		return
	print("	<--- %s took %s dmg" % [creaName, dmg])

	$icon/life_bar.value = hp
	if !isAlive:
		set_collision_layer_value(1, false)
		$Area2D.set_collision_layer_value(3, false)
		playDeathEffect()
		

func _on_button_button_down():
	if (callback_dic.has("drag")):
		print("call")
		callback_dic["drag"].call(self)

func _on_button_button_up():
	if (callback_dic != null):
		callback_dic["drop"].call()
		
func playAttack():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.4)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.finished.connect(func(): scale = Vector2(0.93,0.93))

func _on_drag():
	print("dragging %s" % creaName)
	z_index += 1
	#set_collision_layer_value(3, false)
	set_collision_mask_value(3, false)
	last_known_cell = get_cell_pos()
	previous_cell = last_known_cell
	isDragged = true

	
	
func _on_drop():
	position = Constants.get_pos_from_grid_cell(get_cell_pos())
	z_index -= 1
	#set_collision_layer_value(3, true)
	set_collision_mask_value(3, true)
	isDragged = false
	last_known_cell = get_cell_pos()
	previous_cell = last_known_cell
	
func _on_area_2d_area_entered(area):
	var area_parent = area.get_parent()
	callback_dic["ally_collision"].call(self, area_parent)
