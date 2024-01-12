extends HBoxContainer

var lvl_label = "LV %s"
var character: Character
var click_callback: Callable
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setCharacter(chara: Character):
	character = chara

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (character == null):
		set_no_char()
		return
	else:
		var job: Job = character.getJob()
		$resumeContainer/stats/level.text = lvl_label % job.level
		$resumeContainer/name.text = "%s %s" % [character.firstname, job.name]
		$resumeContainer/stats/boost_icon/boost.text = str(job.skillBoost)
		$portrait.setCreature(job)
		$resumeContainer.visibility_layer = 1
	if (character.jobs.size() == 1):
		$resumeContainer/jobs/job2.visibility_layer = 0
		$resumeContainer/jobs/job3.visibility_layer = 0
	else:
		$resumeContainer/jobs/job2.visibility_layer = 1
		$resumeContainer/jobs/job3.visibility_layer = 1
	pass
	
func set_no_char():
	$portrait.setCreature(null)
	$resumeContainer.visibility_layer = 0

func set_callback(callback: Callable):
	click_callback = callback

func _on_portrait_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		click_callback.call(character)

