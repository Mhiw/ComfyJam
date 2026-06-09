extends Area3D

@export var npc_id: String = "cubeman"
var player_nearby := false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_nearby = true


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_nearby = false


func _input(event: InputEvent):
	if player_nearby and Input.is_action_just_pressed("interact"): # E
		var line: String = GameManager.get_dialogue(npc_id)
		print(line)
