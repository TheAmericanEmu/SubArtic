extends Camera3D

var depth
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var surface = self.global_position
	surface.y = 0
	depth = self.global_position.distance_to(surface)
	
	
