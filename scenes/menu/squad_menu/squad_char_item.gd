extends HBoxContainer

signal swap_button_clicked

var hp_label = "PV: %s"
var lvl_label = "LV %s"
var character: Character

# Called when the node enters the scene tree for the first time.
func _ready():
	$swapButton.pressed.connect(self.on_swapClicked)
	#$swapButton.pressed.connect(self.on_swapClicked())
	pass # Replace with function body.

func _process(_delta):
	if (character == null):
		set_no_char()
		return
		
	var job = character.getJob()
		
	$portrait/name.text = "%s %s" % [character.name, job.name]
	$portrait.setCreature(job)
	$resumeContainer.set_visible(true)
	$resumeContainer/stats/boost_icon/boost.text = "%s" % job.skillBoost
	$resumeContainer/stats/hp.text = hp_label % job.hp
	
	$xp_box/current_lvl.text = lvl_label % job.level

	var next_level = job.xp+1500
	$xp_box/xpBar.max_value = next_level
	$xp_box/xpBar.value = job.xp
	$xp_box/xpBar/missingPx.text = "1500"
	
	updateJobs()
			
	$resumeContainer.visibility_layer = 1

func setCharacter(chara: Character):
	self.character = chara

# Disable view when no character is filling this view
func set_no_char():
	$portrait.setCreature(null)
	$resumeContainer.visibility_layer = 0
	$xp_box/xpBar.max_value = 1
	$xp_box/xpBar.value = 0
	$xp_box/xpBar/missingPx.text = "0"
	$xp_box/current_lvl.text = lvl_label % "--"


func on_swapClicked():
	swap_button_clicked.emit()

func updateJobs():
	var currentJobId = character.currentJob
	var jobLvl = lvl_label % character.getJob().level
	
	if (character.jobs.size() == 1):
		$resumeContainer/jobs/job2.visibility_layer = 0
		$resumeContainer/jobs/job3.visibility_layer = 0
	else:
		$resumeContainer/jobs/job2.visibility_layer = 1
		$resumeContainer/jobs/job3.visibility_layer = 1
	
	match currentJobId:
		0:
			$resumeContainer/jobs/job1.disabled = false
			$resumeContainer/jobs/job1/job1_lvl.visibility_layer = 1
			$resumeContainer/jobs/job1/job1_lvl.text = jobLvl
			$resumeContainer/jobs/job2.disabled = true
			$resumeContainer/jobs/job2/job2_lvl.visibility_layer = 0
			$resumeContainer/jobs/job3.disabled = true
			$resumeContainer/jobs/job3/job3_lvl.visibility_layer = 0
		1:
			$resumeContainer/jobs/job1.disabled = true
			$resumeContainer/jobs/job1/job1_lvl.visibility_layer = 0
			$resumeContainer/jobs/job2.disabled = false
			$resumeContainer/jobs/job2/job2_lvl.visibility_layer = 1
			$resumeContainer/jobs/job2/job2_lvl.text = jobLvl
			$resumeContainer/jobs/job3.disabled = true
			$resumeContainer/jobs/job3/job3_lvl.visibility_layer = 0
		2:
			$resumeContainer/jobs/job1.disabled = true
			$resumeContainer/jobs/job1/job1_lvl.visibility_layer = 0
			$resumeContainer/jobs/job2.disabled = true
			$resumeContainer/jobs/job2/job2_lvl.visibility_layer = 0
			$resumeContainer/jobs/job3.disabled = false
			$resumeContainer/jobs/job3/job3_lvl.text = jobLvl
			$resumeContainer/jobs/job3/job3_lvl.visibility_layer = 1
