extends CanvasLayer


func _ready() -> void:
	hide()

func open() -> void:
	show()

func close() -> void:
	hide()
	PauseMenu.show()

func _on_back_pressed() -> void:
	close()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and visible:
		close()


func _on_mouse_sensitivity_value_changed(value: float) -> void:
	GameManager.player_sensitivity = value
