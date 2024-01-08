class_name Damage extends Node

var dmg: int
var element: Constants.elements = Constants.elements.NONE
var weapon : Constants.weapons = Constants.weapons.STAFF

func _init(amount: int, _elt: Constants.elements, _weap: Constants.weapons):
	dmg = amount
	element = _elt
	weapon = _weap

