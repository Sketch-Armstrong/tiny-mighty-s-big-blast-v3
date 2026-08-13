extends Control
#
#
#@onready var input_button_scene = preload("res://resources/menus/input settings/input_button.tscn")
#@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList
#
#
#var is_remapping = false
#var action_to_remap = null
#var remapping_button = null
#
#var input_actions = {
	#"tiny_move_up": "Up",
	#"tiny_move_down": "Down",
	#"tiny_move_left": "Left",
	#"tiny_move_right": "Right",
	#"taunt": "Style",
#}
#
#
#
#func _ready() -> void:
	#_load_keybindings_from_settings()
	#_create_action_list()
#
#
#func _load_keybindings_from_settings():
	#var keybindings = ConfigFileHandler.load_keybindings()
	#for action in keybindings.keys():
		#InputMap.action_erase_events(action)
		#InputMap.action_add_event(action, keybindings[action])
#
##func _process(delta: float) -> void:
	##if Input.is_action_just_pressed("taunt"):
		##print("taunt")
	##if Input.is_action_just_pressed("tiny_move_right"):
		##print("tiny_move_right")
	##if Input.is_action_just_pressed("tiny_move_left"):
		##print("tiny_move_left")
	##if Input.is_action_just_pressed("tiny_move_up"):
		##print("tiny_move_up")
	##if Input.is_action_just_pressed("tiny_move_down"):
		##print("tiny_move_down")
#
##over here he had some video settings button signal connection functions
#
#func _create_action_list():
	#for item in action_list.get_children():
		#item.queue_free()
	#
	#for action in input_actions:
		#var button = input_button_scene.instantiate()
		#var action_label = button.find_child("LabelAction")
		#var input_label = button.find_child("LabelInput")
		#
		#action_label.text = input_actions[action]
		#
		#var events = InputMap.action_get_events(action)
		#if events.size() > 0:
			#input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		#else:
			#input_label.text = ""
		#
		#action_list.add_child(button)
		#button.pressed.connect(_on_input_button_pressed.bind(button, action))
#
#func _on_input_button_pressed(button, action):
	#if !is_remapping:
		#is_remapping = true
		#action_to_remap = action
		#remapping_button = button
		#button.find_child("LabelInput").text = "Press key to bind..."
#
#
#
#func _input(event):
	#if is_remapping:
		#if (
			#event is InputEventKey ||
			#(event is InputEventMouseButton && event.pressed)
		#):
			##block double clicking
			#if event is InputEventMouseButton && event.double_click:
				#event.double_click = false
			#
			#InputMap.action_erase_events(action_to_remap)
			#
			##remove duplicate inputs from previously assigned actions. 
			##This wasn't here in the tutorial, but was in the settings tut
			#
			#for action in input_actions:
				#if InputMap.action_has_event(action, event):
					#InputMap.action_erase_event(action, event)
					#var buttons_with_action = action_list.get_children().filter(func(button):
						#return button.find_child("LabelAction").text == input_actions[action]
					#)
					#for button in buttons_with_action:
						#button.find_child("LabelInput").text = ""
			#
			#InputMap.action_add_event(action_to_remap, event)
			#ConfigFileHandler.save_keybinding(action_to_remap, event)
			#_update_action_list(remapping_button, event)
			#
			#is_remapping = false
			#action_to_remap = null
			#remapping_button = null
			#
			#accept_event()
#
#
#func _update_action_list(button, event):
	#button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)") 
#
#
#func _on_reset_button_pressed() -> void:
	#InputMap.load_from_project_settings()
	#for action in input_actions:
		#var events = InputMap.action_get_events(action)
		#if events.size() > 0:
			#ConfigFileHandler.save_keybinding(action, events[0])
	#_create_action_list()
