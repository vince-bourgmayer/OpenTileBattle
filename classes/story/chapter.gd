class_name Chapter extends Resource

@export var id: int
@export var stages : Array[Stage] = []
@export var alreadyDone: bool = false
@export var unlocked: bool = false
# TODO add mecanism to trigger a reward like unlocking next chapter or another story

func _init(chapterId: int):
	id = chapterId
