class_name Story extends Resource

@export var title : String
@export var background : String
@export var chapters : Array[Chapter] = []
@export var unlocked: bool = false
const art_dir_path: String = "res://art/story/"

func _init(p_title: String, p_art_path: String):
	title = p_title
	background = "%s%s" % [art_dir_path, p_art_path]
