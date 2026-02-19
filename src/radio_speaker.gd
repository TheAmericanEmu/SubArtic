class_name radio_speaker extends AudioStreamPlayer3D


func play_audio_seq(input_list:Array[AudioStream],call_back_func:Callable=func():
	pass
	):
	for audio in input_list:
		self.stream=audio
		self.play()
		await self.finished
	call_back_func.call()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
