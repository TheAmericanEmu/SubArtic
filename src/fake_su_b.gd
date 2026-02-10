extends Node3D

@onready var window_blocker: CSGCylinder3D = $Window_Blocker
@onready var real_sub: RealSub = $"../../Real_Sub"
@onready var sub_comp: sub_hud = $Hud/Control

var is_main_window_open :=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_toogle_main_window()

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
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update_computer()
