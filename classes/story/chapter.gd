class_name Chapter extends Resource

@export var id: int
@export var stages : Array[Stage] = []

func _init(chapterId: int):
	id = chapterId
