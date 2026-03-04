extends Node3D

@onready var radio_speaker_obj: radio_speaker = $"../PlayerSpace/Fake_SuB/radio_speaker"
@onready var fake_su_b: fake_sub = $"../PlayerSpace/Fake_SuB"
@onready var lift_noise: AudioStreamPlayer3D = $"../PlayerSpace/Fake_SuB/Lift_noise"
@onready var real_sub: RealSub = $"../Real_Sub"
@onready var marker_portal_end: Marker3D = $Marker_portal_end
@onready var cave_blocker: StaticBody3D = $"../Node3D/CaveBlocker"



var main_poi_recored:= 0
var total_main_poi:int=0
var ending_choice=false
var side_poi_recored:=0
var total_side_poi:=0
var is_opening_scence:=false
# Called when the node enters the scene tree for the first time.

func _end_seq():
	if is_opening_scence==true:
		lift_noise.stop()
		fake_su_b._toogle_main_window()
		real_sub.allow_movement=true
		is_opening_scence=false

func _start_seq():
	var o1="res://Data/sounds/voicelines/Beginning 1.wav"
	var o2="res://Data/sounds/voicelines/Beginning 2.wav"
	var o3="res://Data/sounds/voicelines/Beginning 3.wav"
	var o4="res://Data/sounds/voicelines/Beginning 4.wav"
	is_opening_scence=true
	real_sub.allow_movement=false
	var unfade_black :=  get_tree().create_tween()
	lift_noise.play()
	unfade_black.tween_property(Hud.black_screen,"modulate",Color(0,0,0,0),2)
	radio_speaker_obj.play_audio_seq([load(o1),load(o2),load(o3),load(o4)],self._end_seq)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape") and is_opening_scence:
		_end_seq()
		if radio_speaker_obj.playing:
			radio_speaker_obj.stop()
			radio_speaker_obj.play_audio_seq([])

func _ready() -> void:
	randomize()

	
	#Count all Points
	for node in get_tree().get_nodes_in_group("POI"):
		if node is POI:
			if node.is_main_POI==true:
				total_main_poi+=1
			else:
				total_side_poi+=1

	_start_seq()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _enter_undiscovered_poi() -> void:
	var ran = randi_range(0,1)
	var stream:AudioStream
	print(ran)
	if ran ==0:
		stream = load("res://Data/sounds/voicelines/Near POI 1.wav")
	elif ran == 1:
		stream = load("res://Data/sounds/voicelines/Near POI 2.wav")
	radio_speaker_obj.play_audio_seq([stream])


func _discovered_new_poi(id:int) -> void:
	main_poi_recored+=1
	
	
	var stream:AudioStream
	
	var place_voice_line:AudioStream
	
	var end_of_seq_line:AudioStream
	
	if id==1:
		place_voice_line=load("res://Data/sounds/voicelines/City.wav")
	elif id==2:
		place_voice_line=load("res://Data/sounds/voicelines/Sub.wav")
	elif id==3:
		place_voice_line=load("res://Data/sounds/voicelines/Cave.wav")
	print(total_main_poi,main_poi_recored)
	if total_main_poi==main_poi_recored:
		end_of_seq_line=load("res://Data/sounds/voicelines/All Points Completed.wav")
		cave_blocker.queue_free()
		ending_choice=true
	else:
		end_of_seq_line=load("res://Data/sounds/voicelines/Need More Points.wav")
	if true:
		stream = load("res://Data/sounds/voicelines/Scanned.wav")
	
	radio_speaker_obj.play_audio_seq([stream,place_voice_line,end_of_seq_line])
	
	


func _on_real_sub_has_enter_portal_room() -> void:
	var pull_in_tween := create_tween()
	real_sub.allow_movement=false
	fake_su_b._on_helm_enter_helm()
	pull_in_tween.tween_property(real_sub,"global_position",marker_portal_end.global_position,1)
	pull_in_tween.set_trans(Tween.TRANS_EXPO)
	await pull_in_tween.finished
	Hud.black_screen.modulate=Color(0.0, 0.0, 0.0, 1.0)
	get_tree().change_scene_to_file("res://Data/Scences/ending_portal.tscn")


func _on_cave_voice_tigger_body_entered(body: Node3D) -> void:
	if body is RealSub:
		radio_speaker_obj.play_audio_seq([load("res://Data/sounds/voicelines/Portal.wav")])


func _on_hoist_tigger_body_entered(body: Node3D) -> void:
	if body is RealSub and ending_choice==true:
		var pull_in_tween := create_tween()
		real_sub.allow_movement=false
		fake_su_b._on_helm_enter_helm()
		radio_speaker_obj.play_audio_seq([load("res://Data/sounds/voicelines/Hoist.wav")])
		pull_in_tween.tween_property(real_sub,"global_position",marker_portal_end.global_position,1)
		pull_in_tween.set_trans(Tween.TRANS_EXPO)
		fake_su_b._toogle_main_window()
		await pull_in_tween.finished
		Hud.black_screen.modulate=Color(0.0, 0.0, 0.0, 1.0)
		get_tree().change_scene_to_file("res://Data/Scences/main_menu.tscn")
