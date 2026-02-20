class_name HUD extends CanvasLayer

@onready var interaction_label: Label = $Hud/Interaction_Label
@onready var black_screen: Panel = $Hud/BlackScreen

func set_ineratcion_text(text:String):
	interaction_label.text=text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
