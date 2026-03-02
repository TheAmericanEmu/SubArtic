extends Node

@onready var sub_viewport = $EasterEgg # Replace with the actual path to your SubViewport
@onready var display_quad = $Sub_Computer # Or the node displaying the texture
@onready var node_2d: Node2D = $EasterEgg/Node2D

func _unhandled_input(event: InputEvent) -> void:
	# Example for a mouse click (adjust logic for other events)
	if event is InputEventMouseButton and event.pressed:
		var viewport_size = sub_viewport.size
		# Assuming you have a way to convert global mouse position to the local position 
		# on the 3D surface/quad (this part is complex and depends on your specific setup).

		# A simpler approach for 2D is using a Control node and its get_local_mouse_position()

		#If using a Control node like TextureRect in 2D:
		var local_pos = node_2d.get_local_mouse_position()
		var adjusted_event = event.duplicate()
		adjusted_event.position = local_pos
		sub_viewport.push_input(adjusted_event)
		
		# For 3D interaction, consider using Physics body picking and custom signal forwarding.
		pass # Implement 3D input logic
