extends KinematicBody

onready var head : Spatial = $Camera
onready var ground_check: RayCast = $GroundCheck
onready var body: MeshInstance = $Body

var direction:Vector3 = Vector3()
var h_velocity:Vector3 = Vector3()
var movement:Vector3 = Vector3()
var gravity_vec: Vector3 = Vector3()
var full_contact: bool = false
var is_master:bool = false


const MIN_CAMERA_ANGLE : int = -60
const MAX_CAMERA_ANGLE : int = 60
const GRAVITY : int = 20


export(float) var player_speed: float = 10.0
export(float) var h_acceleration = 6
export(float) var air_acceleration = 1
export(float) var normal_acceleration = 6
export(float) var jump_impulse: float = 10.0
export(float) var camera_sensitivity: float = 0.05



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if is_master:
		direction =_get_movement_direction()
		full_contact = ground_check.is_colliding()
		
		# Vertical Movement
		if not is_on_floor():
			gravity_vec += Vector3.DOWN * GRAVITY * delta
			h_acceleration = air_acceleration
		elif is_on_floor() and full_contact:
			gravity_vec = -get_floor_normal() * GRAVITY
			h_acceleration = normal_acceleration
		else:
			gravity_vec = -get_floor_normal()
			h_acceleration = normal_acceleration

		# Jump
		if Input.is_action_just_pressed("jump") and (is_on_floor() or ground_check.is_colliding()):
			print("jumpPressed")
			gravity_vec = Vector3.UP * jump_impulse
		
		# planer Movement
		h_velocity = h_velocity.linear_interpolate(direction * player_speed, h_acceleration * delta)
		movement.z = h_velocity.z + gravity_vec.z
		movement.x = h_velocity.x + gravity_vec.x
		movement.y = gravity_vec.y
		move_and_slide(movement, Vector3.UP)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		_handle_camera_rotation(event)


"""
To handle camera motion
@params event
"""
func _handle_camera_rotation(event):
	rotate_y(deg2rad(-event.relative.x * camera_sensitivity))
	head.rotate_x(deg2rad(event.relative.y * camera_sensitivity))
	head.rotation.x = clamp( head.rotation.x , deg2rad(MIN_CAMERA_ANGLE), deg2rad(MAX_CAMERA_ANGLE))

"""
Handle Movement
"""
func _get_movement_direction()->Vector3:
	var dir = Vector3()
	
	if Input.is_action_pressed("forward"):
		dir += transform.basis.z
	elif Input.is_action_pressed("backward"):
		dir -= transform.basis.z
	if Input.is_action_pressed("left"):
		dir += transform.basis.x
	elif Input.is_action_pressed("right"):
		dir -= transform.basis.x
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	return dir.normalized()


func initialize(id):
	name = str(id)
	if id == Net.net_id:
		is_master = true
	else:
		var material = body.get_surface_material(0)
		material.albedo_color = Color8(255,0,0,255)
		body.set_surface_material(0,material)



