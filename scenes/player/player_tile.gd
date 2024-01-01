extends Area2D
signal hit

var isSelected = false
var justUnselected = false
var grid_topleft = Vector2.ZERO
var grid_botRight = Vector2.ZERO
var colliding_pos = Vector2.ZERO
var colliding = false

var charName
var squadPos

func _ready():
	pass
	
func _process(_delta):
	var tilePos = getTilePos(position)
	if isSelected:
		position = get_global_mouse_position()
		tilePos = getTilePos(position)
		if (colliding and colliding_pos != tilePos):
			print("selected %s do not collide anymore on pos %s" % [charName, tilePos])
			colliding = false
	elif (colliding and colliding_pos == tilePos):
		print("%s do not collide anymore at %s" % [charName, tilePos])
		colliding = false
	
	if (justUnselected):
		position = convertVectorTile_to_pos(getTilePos(position))
		
	if (colliding == false):
		$hitbox.set_deferred("disabled", false)
		
		
	self.position = position.clamp(grid_topleft+Constants.tileSize/2, grid_botRight-Constants.tileSize/2)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and $portrait.get_rect().has_point(to_local(event.position)):
			isSelected = true
			justUnselected = false

		elif event.is_released():
			if isSelected:
				justUnselected = true
				var debug = "%s new pos : %s" % [charName, getTilePos(position)]
				print(debug)
				print("%s is colliding ? %s, has hitbox disabled ? %s" % [charName, colliding, $hitbox.disabled])
			else:
				justUnselected = false
			isSelected = false

func start(gridTopLeft, gridTopRight, startPos, texture):#
	grid_topleft = gridTopLeft
	grid_botRight = gridTopRight
	$portrait.texture = load(texture)
	position = convertVectorTile_to_pos(startPos)
	
func defineChar(char_name, squad_Pos):
	charName = char_name
	squadPos = squad_Pos
	
func convertVectorTile_to_pos(pos):
	return grid_topleft+(pos * Constants.tileSize)-Constants.tileSize/2
	
func getTilePos(pos):
	var offset = grid_topleft
	var halfTile = Constants.tileSize/2
	var formatted_position = pos-offset+halfTile
	return (formatted_position / Constants.tileSize).round()


func _on_area_entered(area):
	colliding_pos = getTilePos(area.position)
	var origin_pos = getTilePos(position)
	if (colliding_pos == origin_pos):
		print("both are on same pos")
		return
	
	if (colliding == true):
		print("%s is already colliding: ignore" % charName)
		return
	else:
		colliding = true
		
	if (isSelected):
		print("selected %s got colision at %s" % [charName, colliding_pos])
		$hitbox.set_deferred("disabled", true)
	else :
		print("%s got colision at %s" % [charName, colliding_pos])
		#$hitbox.set_deferred("disabled", true) #ne marche pas contrairement a 'if isSelected'
	
func _on_area_exited(_area):
	if (isSelected ):
		print("selected %s lost colision at " % [charName, getTilePos(position)])
		#position = convertVectorTile_to_pos(colliding_pos)
		pass
	elif(colliding):
		position = convertVectorTile_to_pos(colliding_pos)
		print("%s lost colision " % charName)

