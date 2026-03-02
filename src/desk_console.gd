extends Node3D


@onready var control: radar_contoller = $Radar/Control/Control
@onready var sub_comp: sub_hud = $Hud/Control

func _update_computer():
	sub_comp.depth=100
	sub_comp.speed=1
	sub_comp.power_left=52
	sub_comp.fornt_health=75
	sub_comp.mid_heath=50
	sub_comp.aft_health=80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_computer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	control._update_radar_point(0.5,0.5)
	
