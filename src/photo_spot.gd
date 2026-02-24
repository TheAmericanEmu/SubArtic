extends Area3D

var is_player_in :=false

signal request_take_pic
@onready var fake_su_b: fake_sub = $".."
@onready var mesh_instance_3d: AnimatedSprite3D = $"../DART/MeshInstance3D"
@onready var player_camera: Camera3D = $"../../CharacterBody3D/Cam/Camera"



# Called when the node enters the scene tree for the first time.

var is_player_in_dart_cam=false


func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use") and is_player_in and fake_su_b.real_sub.current_poi.has_been_found==false :
		is_player_in_dart_cam=true
		fake_su_b.real_sub.current_poi.cam.make_current()
		Hud.set_ineratcion_text("")
		var cam=fake_su_b.real_sub.current_poi.cam
		var cam_tween = create_tween()
		cam_tween.tween_property(cam,"global_transform",cam.global_transform,1)
		cam_tween.parallel()
		var cam_rot_tween=create_tween()
		cam_rot_tween.tween_property(cam,"global_rotation",cam.global_rotation,1)
		cam_tween.stop()
		cam.global_position=fake_su_b.real_sub.cam_launch_point.global_position
		cam_tween.play()
		CamHud.show()
		Hud.hide()
		cam_tween.finished.connect(func():

			fake_su_b.real_sub.current_poi.ani_player.play("Cutscence")
			)
		fake_su_b.real_sub.current_poi.ani_player.animation_finished.connect(func(random_var):
			CamHud._random_static=false
			CamHud.visible=false
			player_camera.make_current()
			Hud.show()
			)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_player_in_dart_cam:
		var cam=fake_su_b.real_sub.current_poi.cam
		CamHud.depth=cam.depth
	pass


func _on_body_entered(body: Node3D) -> void:
	if body is player:
		is_player_in=true
		Hud.set_ineratcion_text("Press Space To interact with DART System")

func _on_body_exited(body: Node3D) -> void:
	if body is player:
		is_player_in=false
		Hud.set_ineratcion_text("")
