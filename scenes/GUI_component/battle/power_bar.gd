extends Control

signal power_bar_filled
#const darkPurple = "390e73"
#const lightPurple = "9476c2"

var barToFill: int = 0
var barCount = 3

func consumePowerBar():
	var bar = getBarToFill
	if bar.value <= 100:
		return
	bar.value = 0
	if (barToFill > 0):
		barToFill -= 1
		power_bar_filled.emit() #may be removed based on implementation choice
	
func addPower(amount: int):
	var bar = getBarToFill()
	if (barToFill == barCount-1 and bar.value < bar.max_value): # is last bar
		bar.value += amount
	if (bar.value == bar.max_value and barToFill < barCount):
		barToFill += 1
		power_bar_filled.emit()
	
	
func getBarToFill():
		match (barToFill):
			0:
				return $first_bar
			1: 
				return $second_bar
			2:
				return $third_bar
