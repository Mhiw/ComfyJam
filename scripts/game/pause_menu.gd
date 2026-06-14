extends CanvasLayer


func _ready() -> void:
	hide()

func open() -> void:
	show()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func close() -> void:
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_resume_pressed() -> void:
	close()

func _on_settings_pressed() -> void:
	hide()
	Settings.open()

func _on_quit_pressed() -> void:
	get_tree().quit()
	

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if PauseMenu.visible:
			PauseMenu.close()
		else:
			PauseMenu.open()
