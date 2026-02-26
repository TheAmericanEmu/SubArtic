class_name sub_hud extends CanvasLayer

@onready var depth_label: Label = $Depth/Label
@onready var speed_label: Label = $Speed/Label
@onready var power_label: Label = $Power/Label

@onready var front: ColorRect = $SectionHealth/Front
@onready var mid: ColorRect = $SectionHealth/Mid
@onready var aft: ColorRect = $SectionHealth/Aft

func get_color_hsv(value: float, min_value: float, max_value: float) -> Color:
	var t = clamp((value - min_value) / (max_value - min_value), 0.0, 1.0)
	return Color.from_hsv((1.0 - t) * 0.33, 1, 1) # 0.33 hue ≈ green, 0 hue = red

var depth:=100.0:
	set(new_value):
		depth_label.text="Depth: "+str(roundf(new_value))+" M"
		depth=new_value

var power_left:=100.0:
	set(new_value):
		power_label.text="⚡: "+str(roundf(new_value))+" %"
		power_left=new_value

var fornt_health:=100.0:
	set(new_value):
		front.color=get_color_hsv(new_value,100,0)
		fornt_health=new_value

var mid_heath:=100.0:
	set(new_value):
		mid.color=get_color_hsv(new_value,100,0)
		mid_heath=new_value

var aft_health:=100.0:
	set(new_value):
		aft.color=get_color_hsv(new_value,100,0)
		aft_health=new_value


var speed:=1:
	set(new_value):
		if new_value==3:
			speed_label.text="Full"
		elif new_value==2:
			speed_label.text="Half"
		elif new_value==1:
			speed_label.text="Slow"
		speed=new_value
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
