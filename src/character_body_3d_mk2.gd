extends CharacterBody3D

@export var cam:Node3D
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var mous_sen:=0.1
@export var real_sub:RealSub
func _ready():
# Capture the mouse for FPS-style control
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	real_sub.is_poilting=true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cam.rotate_y(-event.relative.x*0.01)
		var pitch_rotate = cam.rotation_degrees.x - event.relative.y* mous_sen
		var new_pitch = clampf(pitch_rotate,-90,90)

		cam.rotation_degrees.x=new_pitch
	if event.is_action("escape") and real_sub.is_poilting==true:
		real_sub.is_poilting=false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if real_sub.is_poilting==false:
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("left", "right", "foward", "back")
		var direction := (cam.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
