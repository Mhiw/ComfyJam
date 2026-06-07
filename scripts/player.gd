extends CharacterBody3D

@export var speed: float = 10
@export var acceleration: float = 1
@export var jump_height: float = 5
@export var gravity: float = -10
@export var camera: Camera3D
@export var head: Node3D
@export var sensitivity: float = 1

var rotation_x: float

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func jump() -> void:
	if is_on_floor():
		velocity.y += jump_height

func move(dir: Vector3) -> void:
	velocity += dir

func process_input() -> void:
	if Input.is_action_pressed("movement_right"):
		velocity.x -= 1
	if Input.is_action_pressed("movement_left"):
		velocity.x += 1
	if Input.is_action_pressed("movement_forward"):
		velocity.z -= 1
	if Input.is_action_pressed("movement_back"):
		velocity.z += 1
	if Input.is_action_pressed("movement_jump"):
		jump()

func process_movement() -> void:
	move_and_slide()

	velocity = Vector3(0, 0, 0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity * 0.01)
		
		rotation_x -= event.relative.y * sensitivity * 0.01
		rotation_x = clamp(rotation_x, -PI / 2, PI / 2)

		head.rotation.x = rotation_x

func _process(delta: float) -> void:
	process_input()
	process_movement()
