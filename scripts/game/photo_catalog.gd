extends CanvasLayer

@onready var photo_container = $VBoxContainer/PhotoThumbnails

func _ready():
	hide()

func open():
	show()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	load_photos()

func close():
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func load_photos():
	for child in photo_container.get_children():
		child.queue_free()
	
	for texture in GameManager.photos:
		var img = TextureRect.new()
		img.texture = texture
		img.custom_minimum_size = Vector2(200, 112)
		img.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		photo_container.add_child(img)


func _on_close_pressed() -> void:
	close()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and visible:
		close()
