class_name sub_hud extends Control

@onready var depth_label: Label = $Depth/Label


var depth:=100.0:
	set(new_value):
		depth_label.text="Depth: "+str(roundf(new_value))+" M"
		depth=new_value
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
