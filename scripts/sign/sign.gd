extends Node3D

@export var location_counter: int = 0
@export var locations: Array[Node3D]
@export var contents: Array[Array]

func move_location() -> void:
	global_position = locations[location_counter].global_position
	global_rotation = locations[location_counter].global_rotation
	print(locations[location_counter].global_position)
	location_counter += 1
	if location_counter > locations.size() - 1:
		location_counter = 0
	
	$text/Over.text = contents[location_counter][0]
	$text/Under.text = contents[location_counter][1]

func _ready() -> void:
	$text/Over.text = contents[location_counter][0]
	$text/Under.text = contents[location_counter][1]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_move_sign"):
		move_location()
	#print(location_counter)
