extends Control
var max_time: int 
const default_max_time = 4
var started = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$timer.wait_time = default_max_time
	$timeBar.value = 100
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (started == true and $timer.paused == false):
		$timeBar.value =  $timer.time_left/$timer.wait_time  * 100
	pass

func startTimer():
	started = true
	$timer.start()

func pauseTimer():
	$timer.paused = true
	
func resumeTimer():
	$timer.paused = false

func _on_timer_timeout():
	print("Time out")
	started = false
	

