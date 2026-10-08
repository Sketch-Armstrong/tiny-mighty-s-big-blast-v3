extends CheckButton


func _ready() -> void:
	set_pressed_no_signal(GlobalMiscOptionsSave.global_fullscreen_bool)

func _on_toggled(toggled_on: bool) -> void:
	GlobalMiscOptionsSave.determine_window_mode(toggled_on)


func _on_focus_entered() -> void:
	$Sprite2D.show()


func _on_focus_exited() -> void:
	$Sprite2D.hide()
