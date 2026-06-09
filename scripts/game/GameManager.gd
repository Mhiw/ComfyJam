extends Node

var current_day := 1
var dialogue_data := {}

func _ready():
	load_dialogue()

func load_dialogue():
	var file = FileAccess.open("res://scripts/game/dialogue.json", FileAccess.READ)
	dialogue_data = JSON.parse_string(file.get_as_text())
	print("Dialogue loaded: ", dialogue_data)
	
func get_dialogue(npc_id: String):
	return dialogue_data[npc_id][str(current_day)] # Namnet på npcn från .json-filen + dagarna.

func _input(event: InputEvent):
	if Input.is_action_just_pressed("debug_next_day"): # O
		current_day = min(current_day + 1, 3)
		print("Day: ", current_day)
