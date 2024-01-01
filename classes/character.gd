class_name Character

var jobs : Array
var id: int
var currentJob: int = 0
var name: String

func _init(_id: int, firstname: String, jobs_array: Array, currentJob_id: int):
	self.jobs = jobs_array
	self.id = _id
	self.currentJob = currentJob_id
	self.name = firstname


func getJob():
	return jobs[currentJob]
