extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ACCELERATION = 15.0
const FRICTION = 16.0

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * GameManager.player_sensitivity)
		camera.rotate_x(-event.relative.y * GameManager.player_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI / 3, PI / 3)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("take_photo"):
		GameManager.take_photo()
	
	if Input.is_action_just_pressed("open_catalog"):
		PhotoCatalog.open()

	var input := Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction := (transform.basis * Vector3(input.x, 0, input.y)).normalized()


	if direction:
		var horizontal := Vector2(velocity.x, velocity.z)
		var target := Vector2(direction.x, direction.z) * SPEED
		horizontal = horizontal.move_toward(target, ACCELERATION * delta)
		velocity.x = horizontal.x
		velocity.z = horizontal.y
	else:
		var horizontal := Vector2(velocity.x, velocity.z)
		horizontal = horizontal.move_toward(Vector2.ZERO, FRICTION * delta)
		velocity.x = horizontal.x
		velocity.z = horizontal.y

	move_and_slide()
