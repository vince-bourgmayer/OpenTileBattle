extends Control
var max_time: int 
var started = false

var on_timeout_callback : Callable

func set_timeout_callback(callback):
	on_timeout_callback = callback
	

func _ready():
	$timer.wait_time = Constants.default_player_time
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
	
func finish():
	$timer.paused = false
	$timer.stop()
	$timeBar.value = 0

func _on_timer_timeout():
	print("Time out")
	started = false
	on_timeout_callback.call()	
