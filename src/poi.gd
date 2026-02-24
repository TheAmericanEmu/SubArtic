class_name POI extends Area3D

@export var poi_name:String
@export var id:int=1
@export var is_main_POI:=false
@export_category("Cutsence Settings")
@export var ani_player:AnimationPlayer
@export var viewport:SubViewport
@export var cam:Camera3D

signal poi_discovered



var has_been_found:=false

func get_cam_feed()->StandardMaterial3D:
	var cam_feed_mat := StandardMaterial3D.new()
	var mat_texture:= ViewportTexture.new()
	mat_texture.viewport_path=viewport.get_path()
	cam_feed_mat.albedo_texture=mat_texture
	return cam_feed_mat

func discover_poi():
	if not has_been_found:
		has_been_found=true
		print(poi_name," Has been found")
		poi_discovered.emit()

func tigger_static():
	CamHud._random_static=true
