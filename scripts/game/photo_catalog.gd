extends CanvasLayer

@onready var photo_container: GridContainer = $VBoxContainer/PhotoThumbnails
@onready var page_label: Label = $VBoxContainer/NavigationRow/Label
@onready var prev_button: Button = $VBoxContainer/NavigationRow/left
@onready var next_button: Button = $VBoxContainer/NavigationRow/right

const PHOTOS_PER_PAGE = 8
var current_page := 0

func _ready():
	hide()

func open():
	show()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	current_page = 0
	load_photos()

func close():
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func load_photos() -> void:
	for child in photo_container.get_children():
		child.queue_free()

	var total_pages = max(1, ceili(GameManager.photos.size() / float(PHOTOS_PER_PAGE)))
	page_label.text = str(current_page + 1) + " / " + str(total_pages)
	prev_button.disabled = current_page == 0
	next_button.disabled = (current_page + 1) * PHOTOS_PER_PAGE >= GameManager.photos.size()

	var start = current_page * PHOTOS_PER_PAGE
	var end = min(start + PHOTOS_PER_PAGE, GameManager.photos.size())

	for i in range(start, start + PHOTOS_PER_PAGE):
		var img = TextureRect.new()
		img.custom_minimum_size = Vector2(384, 216)
		img.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		img.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		img.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		img.ignore_texture_size = true
		if i < end:
			img.texture = GameManager.photos[i]
		photo_container.add_child(img)

func _on_close_pressed() -> void:
	close()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and visible:
		close()


func _on_left_pressed() -> void:
	if current_page > 0:
		current_page -= 1
		load_photos()

func _on_right_pressed() -> void:
	current_page += 1
	load_photos()
