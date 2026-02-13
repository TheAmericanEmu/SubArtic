extends Area3D

var is_player_in :=false

signal request_take_pic

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use") and is_player_in:
		request_take_pic.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body is player:
		is_player_in=true


func _on_body_exited(body: Node3D) -> void:
	if body is player:
		is_player_in=false
