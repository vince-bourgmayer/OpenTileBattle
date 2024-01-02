extends Control
var max_time: int 
const default_max_time = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	$timer.wait_time = default_max_time
	startTimer()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$timeBar.value =  $timer.time_left/$timer.wait_time  * 100
	pass

func startTimer():
	$timer.start()
	
func pauseTimer():
	$timer.pause()

func _on_timer_timeout():
	print("Time out")

