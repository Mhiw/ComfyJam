extends Node3D

@onready var picture_scene = preload("res://scenes/picture.tscn")

func take_picture() -> void:
	var instance = picture_scene.instantiate()
	#var image = $Sprite3D.texture.get_image()
	#instance.find_child("Sprite3D").texture = ImageTexture.create_from_image(image)
	instance.position = Vector3(0, 10, 0)
	print(get_tree().root.name)
	get_tree().root.add_child(instance)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("take_picture"):
		take_picture()
