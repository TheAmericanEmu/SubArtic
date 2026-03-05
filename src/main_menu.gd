extends Node3D

@onready var control: Control = $CanvasLayer/Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for UI_item:Control in control.get_children():
		UI_item.visible=false
	var fade_in_tween := create_tween()
	fade_in_tween.tween_property(Hud.black_screen,"modulate",Color(0,0,0,0),2)
	await fade_in_tween.finished
	for UI_item:Control in control.get_children():
		UI_item.visible=true
		await get_tree().create_timer(1).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Data/Scences/sub.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Data/Scences/credits.tscn")
