class_name radar_contoller extends Control
@onready var radar: ColorRect = $Radar

func _update_radar_point(x_point,y_point):
	var norm_vect = Vector2(x_point,y_point).normalized()
	radar.set_instance_shader_parameter("Blip Position",norm_vect)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
