extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	print("testing input pausing")
	set_process_input(false)
	await get_tree().create_timer(2.0).timeout
	set_process_input(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("take_damage"):
		print("you pressed 'take damage'")
