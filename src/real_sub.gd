class_name RealSub extends CharacterBody3D

@onready var main_cam: Camera3D = $MainWindowCam/Cam

@onready var main_cam_point: Marker3D = $MainCamPoint

# Called when the node enters the scene tree for the first time.
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var is_poilting := false

#Stats
var depth :=0.00
var power_settings:=1
var power_left:=100.0
var engine_rpm:=0

var for_health:=100
var mid_health:=100
var aft_health:=100

var current_poi:POI = null

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	main_cam.global_transform=main_cam_point.global_transform
	var surface = self.position
	surface.y = 0
	depth = self.position.distance_to(surface)

func _physics_process(delta: float) -> void:
	
	if is_poilting:
	
		# Add the gravity.
		#if not is_on_floor():
			#velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("power_up"):
			if power_settings<3:
				power_settings+=1
		elif Input.is_action_just_pressed("power_down"):
			if power_settings>1:
				power_settings-=1


		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("left", "right", "foward", "back")
		var direction := (self.basis * Vector3(input_dir.y, 0, 0)).normalized()
		
		self.rotate_y(input_dir.x*delta)
		var up_down :=  Input.get_axis("up","down") * (SPEED*power_settings)
		if direction or up_down:
			velocity.x = direction.x * (SPEED*power_settings)
			velocity.z = direction.z * (SPEED*power_settings)
			velocity.y=up_down
			
			power_left-=(abs(input_dir.y)* (power_settings))*0.01
		else:
			velocity.x = move_toward(velocity.x, 0, 0.2)
			velocity.z = move_toward(velocity.z, 0, 0.2)
			velocity.y = move_toward(velocity.y, 0, 0.2)
		move_and_slide()

func do_collison(body:StaticBody3D,sec:int):
	if sec==0:
		for_health-=1
	elif sec==1:
		mid_health-=1
	else:
		aft_health-=1
	print(for_health,"-----",mid_health,"-----",aft_health)
func _on_aft_hit_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("Map"):
		do_collison(body,2)


func _on_mid_hit_box_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("Map"):
		do_collison(body,1)


func _on_for_hit_box_3_body_entered(body: Node3D) -> void:
	if body.is_in_group("Map"):
		do_collison(body,0)


func _on_area_check_box_area_entered(area: Area3D) -> void:
	if area is POI:
		current_poi=area
		if area.has_been_found==false:
			print("Hey This is new")
		
		


func _on_area_check_box_area_exited(area: Area3D) -> void:
	if area is POI:
		current_poi=null
