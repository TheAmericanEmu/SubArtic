extends Node3D

@onready var radio_speaker: AudioStreamPlayer3D = $"../PlayerSpace/Fake_SuB/radio_speaker"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
	var stream:AudioStream
	if true:
		stream = load("res://Data/sounds/voicelines/discovered_poi.wav")
	radio_speaker.stream=stream
	radio_speaker.play()
	
	
	
