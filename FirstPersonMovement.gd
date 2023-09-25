extends CharacterBody3D

@export var speed:float = 5
@export var sprint_speed:float = 7.5
@export var jump_velocity:float = 4.5
@export var mouse_senstivity:float = 0.015 

@onready var camera:Camera3D = $Camera3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity_y = 0
var horizontal_velocity

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_senstivity)
		camera.rotate_x(-event.relative.y * mouse_senstivity)
		
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if Input.is_action_pressed("sprint"):
		horizontal_velocity = Input.get_vector("left", "right", "forward", "backward").normalized() * sprint_speed
		camera.fov = 95
	else:
		horizontal_velocity = Input.get_vector("left", "right", "forward", "backward").normalized() * speed
		camera.fov = 90
	
	velocity = (horizontal_velocity.x * global_transform.basis.x) + (horizontal_velocity.y * global_transform.basis.z)
	
	if is_on_floor():
		velocity_y = jump_velocity if Input.is_action_just_pressed("jump") else 0
	else:
		velocity_y -= gravity * delta
		
	velocity.y = velocity_y
	
	move_and_slide()
