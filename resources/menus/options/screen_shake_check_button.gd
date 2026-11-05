extends CheckButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	set_pressed_no_signal(GlobalMiscOptionsSave.reduce_screen_shake)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_toggled(toggled_on: bool) -> void:
	GlobalMiscOptionsSave.set_reduce_screen_shake(toggled_on)
