extends Node

var current_day := 1
var dialogue_data := {}

var in_dialogue := false

var player_sensitivity = 0.002

var photos := []

func _ready():
	load_dialogue()

func load_dialogue():
	var file = FileAccess.open("res://scripts/game/dialogue.json", FileAccess.READ)
	dialogue_data = JSON.parse_string(file.get_as_text())
	print("Dialogue loaded: ", dialogue_data)
	
func get_dialogue(npc_id: String):
	var npc = dialogue_data[npc_id]
	var name = npc["name"]
	var line = npc[str(current_day)]
	return "(" + name + ")" + ": " + line


func take_photo():
	await RenderingServer.frame_post_draw
	var image = get_viewport().get_texture().get_image()
	var texture = ImageTexture.create_from_image(image)
	photos.append(texture)
	print("Photo taken! Total: ", photos.size())


func _input(event: InputEvent):
	if Input.is_action_just_pressed("debug_next_day"): # O
		current_day = min(current_day + 1, 3)
		print("Day: ", current_day)
