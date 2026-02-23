extends AudioStreamPlayer3D

@onready var fake_su_b: fake_sub = $".."
const METAL_CREAKING = preload("uid://be05gkmfiaxfb")
var random_Sounds = [METAL_CREAKING]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func play_ship_random_sound():
	stream=random_Sounds.pick_random()
	play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if int(fake_su_b.real_sub.depth)%100==0:
		play_ship_random_sound()
	elif randi_range(0,100000)==1:
		play_ship_random_sound()
