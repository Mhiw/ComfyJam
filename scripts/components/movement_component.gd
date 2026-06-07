extends Node


var velocity: Vector3 = Vector3(0, 0, 0)

func _ready() -> void:
	pass

func jump() -> void:
	if body.is_on_floor():
		print("jumping")
		velocity.y += jump_height

func move(dir: Vector3) -> void:
	velocity += dir

func _process(delta: float) -> void:
	velocity.normalized()
	body.velocity = velocity
	body.velocity *= speed * delta * 200
	body.move_and_slide()
	velocity = Vector3(0, 0, 0)
