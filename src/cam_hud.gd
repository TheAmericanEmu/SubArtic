class_name cam_hud extends Control
@onready var static_img: AnimatedSprite2D = $Static
@onready var time_label: Label = $Time
@onready var stats_label: Label = $Stats

var _random_static = false

var depth:=0
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _random_static==true:
		static_img.show()
		static_img.self_modulate.a+=randi_range(-2,2)
	else:
		static_img.hide()
		
	var time_dict = Time.get_datetime_dict_from_unix_time(GameClock.current_unix_time)
	var time_Str = "%02d:%02d:%02d" % [time_dict.hour, time_dict.minute, time_dict.second]
	time_label.text=time_Str
	
	stats_label.text = "Depth: "+str(depth)+" Battery: 95%"
		
