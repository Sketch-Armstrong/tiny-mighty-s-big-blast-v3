extends Button

func _ready() -> void:
	# Show the saved state without firing the toggled signal
	set_pressed_no_signal(GlobalMiscOptionsSave.global_crt_enabled)

func _on_toggled(toggled_on: bool) -> void:
	GlobalMiscOptionsSave.set_crt_option(toggled_on)
