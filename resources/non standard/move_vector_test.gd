extends Node2D

#@onready var input_vector := Input.get_vector("tiny_move_left", "tiny_move_right", "tiny_move_up", "tiny_move_down")

func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("tiny_move_left", "tiny_move_right", "tiny_move_up", "tiny_move_down")
	#print(input_vector)
