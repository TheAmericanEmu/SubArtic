extends Node3D

@onready var radio_speaker: AudioStreamPlayer3D = $"../PlayerSpace/Fake_SuB/radio_speaker"


var main_poi_recored:= 0
var total_main_poi:int=0

var side_poi_recored:=0
var total_side_poi:=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	
	#Count all Points
	for node in get_tree().get_nodes_in_group("POI"):
		if node is POI:
			if node.is_main_POI==true:
				total_main_poi+=1
			else:
				total_side_poi+=1


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
	radio_speaker.stream=stream
	radio_speaker.play()


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
	
	radio_speaker.stream=stream
	radio_speaker.play()
	await radio_speaker.finished
	radio_speaker.stream=place_voice_line
	radio_speaker.play()
	await radio_speaker.finished
	radio_speaker.stream=end_of_seq_line
	radio_speaker.play()
	
	
