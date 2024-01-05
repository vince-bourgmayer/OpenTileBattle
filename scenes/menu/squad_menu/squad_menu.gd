extends Control

var currentSquadNumber = 0
var currentSquad : Squad
# Called when the node enters the scene tree for the first time.
func _ready():
	$squad_nav_bar/squad_num_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	$squad_nav_bar/backButton.pressed.connect(self.prevSquad)
	$squad_nav_bar/nextButton.pressed.connect(self.nextSquad)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$squad_nav_bar/squad_num_label.text = "Squad %s" % (currentSquadNumber+1)
	currentSquad = get_parent().player.getSquad(currentSquadNumber)
	updateSquadView()
	pass

func updateSquadView():
	$squad_char_list/char_1.setCharacter(currentSquad.position1)
	$squad_char_list/char_2.setCharacter(currentSquad.position2)
	$squad_char_list/char_3.setCharacter(currentSquad.position3)
	$squad_char_list/char_4.setCharacter(currentSquad.position4)
	$squad_char_list/char_5.setCharacter(currentSquad.position5)
	$squad_char_list/char_6.setCharacter(currentSquad.position6)

func nextSquad():
	if (currentSquadNumber == 5):
		currentSquadNumber = 0
	else:
		currentSquadNumber += 1

func prevSquad():
	if (currentSquadNumber == 0):
		currentSquadNumber = 5
	else:
		currentSquadNumber -= 1


func _on_char_1_swap_button_clicked():
	print("swap char 1")
	visible = false
	get_parent().openTavernMenu()
	pass # Replace with function body.


func _on_char_2_swap_button_clicked():
	print("swap char 2")
	pass # Replace with function body.


func _on_char_3_swap_button_clicked():
	print("swap char 3")
	pass # Replace with function body.


func _on_char_4_swap_button_clicked():
	print("swap char 4")
	pass # Replace with function body.


func _on_char_5_swap_button_clicked():
	print("swap char 5")
	pass # Replace with function body.


func _on_char_6_swap_button_clicked():
	print("swap char 6")
	pass # Replace with function body.
