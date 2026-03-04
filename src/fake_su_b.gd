class_name fake_sub extends Node3D

@onready var window_blocker: CSGCylinder3D = $Window_Blocker
@onready var real_sub: RealSub = $"../../Real_Sub"
@onready var sub_comp: sub_hud = $Hud/Control
@onready var character_body_3d: player = $"../Player"
@onready var helm: CSGCombiner3D = $HelmObject/Wheel
@onready var helm_area: Area3D = $Helm
@onready var eot: Node3D = $HelmObject/EOT
@onready var helm_point: Marker3D = $Helm/HelmPoint
@onready var lever_sound: AudioStreamPlayer3D = $HelmObject/LeverSound
@onready var under_water_hit: AudioStreamPlayer3D = $UnderWaterHit

var is_main_window_open :=false

signal discovered_new_poi(id:int)

var eot_full_head:float=48.0
var eot_half_spead:float=0.0
var eot_slow_speed:float=-61.0

func _input(event: InputEvent) -> void:
	if event.is_action("left"):
		helm.rotation_degrees.x-=-1
	if event.is_action("right"):
		helm.rotation_degrees.x+=-1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _toogle_main_window():
	if not is_main_window_open:
		var open_tween := get_tree().create_tween()
		open_tween.tween_property(window_blocker,"position",Vector3(-0.99,0.655,0),1)
		is_main_window_open=true
	else:
		var close_tween := get_tree().create_tween()
		close_tween.tween_property(window_blocker,"position",Vector3(-0.99,0.128,0),1)
		is_main_window_open=false

func _update_computer():
	sub_comp.depth=real_sub.depth
	sub_comp.speed=real_sub.power_settings
	sub_comp.power_left=real_sub.power_left
	sub_comp.fornt_health=real_sub.for_health
	sub_comp.mid_heath=real_sub.mid_health
	sub_comp.aft_health=real_sub.aft_health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update_eot_rot():
	var current_rot = eot.rotation_degrees
	if sub_comp.speed==3:
		current_rot.z=eot_full_head
	elif sub_comp.speed==2:
		current_rot.z=eot_half_spead
	elif sub_comp.speed==1:
		current_rot.z=eot_slow_speed
	var move_tween = create_tween()
	
	move_tween.tween_property(eot,"rotation_degrees",current_rot,1)

func _process(delta: float) -> void:
	_update_computer()
	_update_eot_rot()


func _on_area_3d_request_take_pic() -> void:
	if real_sub.current_poi!=null:
		
		real_sub.current_poi.discover_poi()
		discovered_new_poi.emit(real_sub.current_poi.id)


func _on_helm_enter_helm() -> void:
	real_sub.is_poilting=true
	character_body_3d.global_position=helm_point.global_position


func _on_real_sub_change_speed() -> void:
	lever_sound.play()


func _on_real_sub_collison() -> void:
	under_water_hit.play()
