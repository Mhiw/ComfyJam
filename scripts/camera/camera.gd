extends Node3D

@onready var picture_scene = preload("res://scenes/picture.tscn")
@export var viewport: SubViewport
@export var camera: Camera3D
@export var camera_point: Node3D

func take_picture() -> void:
	await RenderingServer.frame_post_draw
	
	var instance = picture_scene.instantiate()
	
	var viewport_texture: ViewportTexture = viewport.get_texture()
	#var image_texture: ImageTexture = ImageTexture.create_from_image(viewport_texture.get_image())
	
	instance.find_child("Sprite3D").texture = viewport_texture
	
	#image_texture.get_image().save_png("res://img.png")
	
	instance.position = Vector3(0, 10, 0)
	get_tree().root.add_child(instance)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("take_picture"):
		take_picture()
	
	camera.global_position = camera_point.global_position
	camera.global_rotation = camera_point.global_rotation
	#camera.position = Vector3(0, 10, 0)
	#print(camera_point.global_position)
