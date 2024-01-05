extends StaticBody2D

var callable_dic
# Called when the node enters the scene tree for the first time.

func set_callables(dictionnary):
	callable_dic = dictionnary

func disable(val):
	$button.disabled = val
	

func setCreature(creature):
	$icon.setCreature(creature)
	
func _on_button_button_down():
	if (callable_dic != null):
		callable_dic["drag"].call(self)

func _on_button_button_up():
	if (callable_dic != null):
		callable_dic["drop"].call(self)
