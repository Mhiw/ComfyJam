extends CanvasLayer


@onready var label = $PanelContainer/VBoxContainer/RichTextLabel

func _ready():
	hide()

func show_dialogue(text: String):
	GameManager.in_dialogue = true
	label.text = text
	show()

func hide_dialogue():
	GameManager.in_dialogue = false
	hide()
