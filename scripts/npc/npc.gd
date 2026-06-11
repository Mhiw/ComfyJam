extends Area3D

@export var npc_id: String = "cubeman"
var player_nearby := false


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_nearby = true


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_nearby = false
		DialogueBox.hide_dialogue() 


func _input(event: InputEvent):
	if player_nearby and Input.is_action_just_pressed("interact"): # E
		var line: String = GameManager.get_dialogue(npc_id)
		print(line)
		if DialogueBox.is_visible():
			DialogueBox.hide_dialogue()
		else:
			DialogueBox.show_dialogue(GameManager.get_dialogue(npc_id))
