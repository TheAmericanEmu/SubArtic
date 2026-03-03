extends Node3D
@onready var alarm: AudioStreamPlayer3D = $PlayerSpace/Fake_SuB/Alarm
@onready var cut_scnce: AnimationPlayer = $CutScnce
@onready var Player: player = $PlayerSpace/Player
@onready var control: sub_hud = $PlayerSpace/Fake_SuB/Hud/Control
@onready var real_sub: RealSub = $Real_Sub
@onready var fake_su_b: fake_sub = $PlayerSpace/Fake_SuB

var ending_tiggered = false

func ending_tiggured():
	ending_tiggered=true

func _ready() -> void:
	control.show_master_warning=true
	Player.allow_input=false
	real_sub.is_poilting=false
	cut_scnce.play("Wake_Up")
	cut_scnce.stop()
	await get_tree().create_timer(1).timeout
	var sound_in_tween = create_tween()
	sound_in_tween.tween_property(alarm,"volume_db",-2,2)
	await sound_in_tween.finished
	var unfade_black :=  get_tree().create_tween()
	unfade_black.tween_property(Hud.black_screen,"modulate",Color(0,0,0,0),2)
	await unfade_black.finished
	cut_scnce.play("Wake_Up")
	await cut_scnce.animation_finished
	Player.allow_input=true
	real_sub.allow_movement=true

func _process(delta: float) -> void:
	if real_sub.depth==0 and not ending_tiggered:
		print("surfaced")
