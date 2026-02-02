extends CharacterBody3D

@export var cam:Camera3D
@export var mous_sens :=0.1
@export var speed =10
func _ready():
# Capture the mouse for FPS-style control
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x*0.01)
		var pitch_rotate = cam.rotation_degrees.x - event.relative.y* mous_sens
		var new_pitch = clampf(pitch_rotate,-90,90)

		cam.rotation_degrees.x=new_pitch

func _process(delta: float) -> void:
	var axis = Input.get_vector("left","right","foward","back")
	print(basis)
	velocity = ((Vector3(-axis.x,0,-axis.y)*global_transform.basis)*speed)
	if not is_on_floor():
		velocity.y=-1
	move_and_slide()
	
	
