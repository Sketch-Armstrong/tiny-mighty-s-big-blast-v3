extends Node2D






func _ready() -> void:
	#$InputSettings/UpRemapButton.brute_force_input_label_controller_up = "testing text rewrite on option ready"
	#var test_pulling_up_value = InputConfigHandler.load_controller_inputs_up()
	#joy_event.button_index = JOY_BUTTON_A
	#print("options menu attempted control loading: ", test_pulling_up_value)
	#print("testing joypad button values: ", joy_event)
			## in here, you need to set all the controls equal to the saved values
			## I think we can also have the "reset to default" option in here, since
			## that can be something in the InputConfigHandler, too
	pass

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_reset_button_pressed() -> void:
	InputConfigHandler.reset_to_default_inputs()


func _on_up_remap_button_done_remapping() -> void:
	$InputSettings/UpRemapButton.grab_focus()


func _on_down_remap_button_done_remapping() -> void:
	pass # Replace with function body.
	$InputSettings/DownRemapButton.grab_focus()


func _on_left_remap_button_done_remapping() -> void:
	pass # Replace with function body.
	$InputSettings/LeftRemapButton.grab_focus()


func _on_right_remap_button_done_remapping() -> void:
	pass # Replace with function body.
	$InputSettings/RightRemapButton.grab_focus()


func _on_taunt_remap_button_done_remapping() -> void:
	pass # Replace with function body.
	$InputSettings/TauntRemapButton.grab_focus()
