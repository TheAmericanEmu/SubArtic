extends Node3D

@onready var radio_speaker_obj: radio_speaker = $"../PlayerSpace/Fake_SuB/radio_speaker"
@onready var fake_su_b: fake_sub = $"../PlayerSpace/Fake_SuB"
@onready var lift_noise: AudioStreamPlayer3D = $"../PlayerSpace/Fake_SuB/Lift_noise"
@onready var real_sub: RealSub = $"../Real_Sub"


var main_poi_recored:= 0
var total_main_poi:int=0

var side_poi_recored:=0
var total_side_poi:=0
var is_opening_scence:=false
# Called when the node enters the scene tree for the first time.

func _end_seq():
	lift_noise.stop()
	fake_su_b._toogle_main_window()
	real_sub.allow_movement=true
	is_opening_scence=false

func _start_seq():
	is_opening_scence=true
	var unfade_black :=  get_tree().create_tween()
	lift_noise.play()
	unfade_black.tween_property(Hud.black_screen,"modulate",Color(0,0,0,0),2)
	radio_speaker_obj.play_audio_seq([load("res://Data/sounds/voicelines/open_line_1.wav"),load("res://Data/sounds/voicelines/opening_line_2.wav"),load("res://Data/sounds/voicelines/Opening_line_3.wav"),load("res://Data/sounds/voicelines/opening_line 4.wav")],self._end_seq)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape") and is_opening_scence:
		_end_seq()
		if radio_speaker_obj.playing:
			radio_speaker_obj.stop()

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
		stream = load("res://Data/sounds/voicelines/new_poi_0.wav")
	elif ran == 1:
		stream = load("res://Data/sounds/voicelines/new_poi_1.wav")
	radio_speaker_obj.play_audio_seq([stream])


func _discovered_new_poi(id:int) -> void:
	main_poi_recored+=1
	
	
	var stream:AudioStream
	
	var place_voice_line:AudioStream
	
	var end_of_seq_line:AudioStream
	
	if id==1:
		place_voice_line=load("res://Data/sounds/voicelines/discovered_city_expo.wav")
	elif id==2:
		place_voice_line=load("res://Data/sounds/voicelines/Sub_Discovered_Point.wav")
	print(total_main_poi,main_poi_recored)
	if total_main_poi==main_poi_recored:
		end_of_seq_line=load("res://Data/sounds/voicelines/get_out_of_line.wav")
	else:
		end_of_seq_line=load("res://Data/sounds/voicelines/findshed_keep_going.wav")
	if true:
		stream = load("res://Data/sounds/voicelines/discovered_poi.wav")
	
	radio_speaker_obj.play_audio_seq([stream,place_voice_line,end_of_seq_line])
	
	
