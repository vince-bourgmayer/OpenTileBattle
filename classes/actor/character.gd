class_name Character extends Resource

@export var jobs : Array[Job]
@export var currentJob: int = 0
@export var firstname: String

func _init(firstname: String, jobs_array: Array[Job], currentJob_id: int):
	self.jobs = jobs_array
	self.currentJob = currentJob_id
	self.firstname = firstname

func getJob():
	return jobs[currentJob]
