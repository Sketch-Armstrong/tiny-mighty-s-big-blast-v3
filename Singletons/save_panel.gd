extends Panel

# Emitted when the player presses the save button
signal save_requested
# Emitted when the player presses the load button
signal reload_requested

@onready var save_button: Button = $HBoxContainer/SaveButton
@onready var load_button: Button = $HBoxContainer/LoadButton


func _ready() -> void:
	save_button.pressed.connect(save_requested.emit)
	load_button.pressed.connect(reload_requested.emit)



func _on_save_button_pressed() -> void:
	pass
		## put in a testing for saving and loading the scores


func _on_load_button_pressed() -> void:
	pass 
		## same here, just to brute force test it
