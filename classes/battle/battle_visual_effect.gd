class_name BattleVisualEffect extends Node2D

var displayTimer: Timer

var timeout_callback : Callable

# Called when the node enters the scene tree for the first time.
func _init():
	visible = false
	displayTimer.wait_time = 1 # default value
	displayTimer.autostart = false
	add_child(displayTimer)

func _set_wait_time(time_in_second: float):
	displayTimer.wait_time = time_in_second

func _set_timeout_callback(callback: Callable):
	timeout_callback = callback
	
func playEffect():
	visible = true
	displayTimer.start()
	
func on_timeout():
	get_parent().remove_child(self)
	timeout_callback.call()

