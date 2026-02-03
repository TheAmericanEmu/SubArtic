extends CharacterBody3D

@export var cam:Camera3D
@export var mous_sens :=0.1
@export var speed :=10


var move_dir: Vector2 # Input direction for movement
var look_dir: Vector2 # Input direction for look/aim

var walk_vel: Vector3 # Walking velocity 
var grav_vel: Vector3 # Gravity velocity 
var jump_vel: Vector3 # Jumping velocity



func _ready():
# Capture the mouse for FPS-style control
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cam.rotate_y(-event.relative.x*0.01)
		var pitch_rotate = cam.rotation_degrees.x - event.relative.y* mous_sens
		var new_pitch = clampf(pitch_rotate,-90,90)

		cam.rotation_degrees.x=new_pitch

func _physics_process(delta: float):
	move_dir = Input.get_vector("left","right","foward","back")
	print(basis)
	var forward = Vector3(move_dir.x,0,move_dir.y)*cam.transform.basis*speed
	velocity=forward
	move_and_slide()
	
	
