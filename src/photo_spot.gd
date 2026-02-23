extends Area3D

var is_player_in :=false

signal request_take_pic
@onready var fake_su_b: fake_sub = $".."
@onready var mesh_instance_3d: AnimatedSprite3D = $"../DART/MeshInstance3D"
@onready var cam_feed: MeshInstance3D = $"../DART/CamFeed"
@onready var sub_viewport: SubViewport = $"../DART/CamFeed/SubViewport"

# Called when the node enters the scene tree for the first time.


func get_cam_feed()->StandardMaterial3D:
	var cam_feed_mat := StandardMaterial3D.new()
	cam_feed_mat.setup_local_to_scene()
	var mat_texture:= ViewportTexture.new()
	mat_texture.setup_local_to_scene()
	mat_texture.viewport_path=sub_viewport.get_path()
	cam_feed_mat.albedo_texture=mat_texture
	return cam_feed_mat

func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use") and is_player_in:
		cam_feed.show()
		fake_su_b.real_sub.current_poi.cam.make_current()
		fake_su_b.real_sub.current_poi.ani_player.play("Cutscence")
		request_take_pic.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body is player:
		is_player_in=true
		Hud.set_ineratcion_text("Press Space To interact with DART System")

func _on_body_exited(body: Node3D) -> void:
	if body is player:
		is_player_in=false
		Hud.set_ineratcion_text("")
