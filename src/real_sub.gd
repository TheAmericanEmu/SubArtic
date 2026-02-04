class_name RealSub extends CharacterBody3D

@onready var main_cam: Camera3D = $MainWindowCam/Cam

@onready var main_cam_point: Marker3D = $MainCamPoint

# Called when the node enters the scene tree for the first time.
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var is_poilting := false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	main_cam.global_transform=main_cam_point.global_transform
	
	print(main_cam.position, main_cam_point.position)

func _physics_process(delta: float) -> void:
	
	if is_poilting:
	
		# Add the gravity.
		#if not is_on_floor():
			#velocity += get_gravity() * delta

		# Handle jump.


		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("left", "right", "foward", "back")
		var direction := (self.basis * Vector3(input_dir.y, 0, 0)).normalized()
		
		self.rotate_y(input_dir.x*delta)
		var up_down :=  Input.get_axis("up","down") * SPEED
		if direction or up_down:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			velocity.y=up_down
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
		move_and_slide()
