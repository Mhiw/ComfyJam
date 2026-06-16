extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 3.0
const ACCELERATION = 15.0
const FRICTION = 16.0

const BOB_FREQUENCY = 2.4   
const BOB_HEIGHT = 0.03    
const BOB_WIDTH = 0.015   
var bob_time: float = 0.0 
var default_cam_pos: Vector3  

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	default_cam_pos = camera.position

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
	
	
	_handle_view_bobbing(delta, direction)

func _handle_view_bobbing(delta: float, direction: Vector3) -> void:
	var horizontal_speed = Vector2(velocity.x, velocity.z).length()
	
	if is_on_floor() and horizontal_speed > 0.1 and direction != Vector3.ZERO:
		bob_time += delta * horizontal_speed * BOB_FREQUENCY
		
		var target_pos = default_cam_pos
		target_pos.y += sin(bob_time) * BOB_HEIGHT
		target_pos.x += cos(bob_time * 0.5) * BOB_WIDTH
		
		camera.position = target_pos
	else:
		bob_time = 0.0
		camera.position = camera.position.lerp(default_cam_pos, delta * 10.0)
