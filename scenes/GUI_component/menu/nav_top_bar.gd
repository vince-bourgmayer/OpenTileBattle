extends Control

func updateCoins(amount: int = 0):
	$HBoxContainer/VBoxContainer/coinsIcon/collectedCoins.text = str(amount)
	
func setTitle(title: String=""):
	$HBoxContainer/VBoxContainer/currentMenu.text = title
