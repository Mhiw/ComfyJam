extends CanvasLayer


@onready var label = $PanelContainer/VBoxContainer/RichTextLabel
@onready var dialogue_animation: AnimationPlayer = $AnimationPlayer

func _ready():
	hide()

func show_dialogue(text: String):
	GameManager.in_dialogue = true
	label.text = text
	show()

func hide_dialogue():
	GameManager.in_dialogue = false
	dialogue_animation.play("close")
	await dialogue_animation.animation_finished
	hide()

func pop_up_anim():
	dialogue_animation.play("pop-up")
