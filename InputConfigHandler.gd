extends Node

var input_config = ConfigFile.new()
var err = input_config.load("user://input_settings.cfg")
const INPUT_SETTINGS_FILE_PATH = "user://input_settings.cfg"


@export var action: String
@export var action_event_index: int = 0

var input_config_controller_button_index
var input_config_controller_axis_index
var input_config_keyboard_keycode

var loading_values_test: Key

var controller_up = InputEventJoypadButton.new()
var controller_down = InputEventJoypadButton.new()
var controller_left = InputEventJoypadButton.new()
var controller_right = InputEventJoypadButton.new()
var controller_taunt = InputEventJoypadButton.new()


var ctr_trigger_right = InputEventJoypadMotion.new()
var ctr_trigger_left = InputEventJoypadMotion.new()

var ls_up = InputEventJoypadMotion.new()
var ls_down = InputEventJoypadMotion.new()
var ls_left = InputEventJoypadMotion.new()
var ls_right = InputEventJoypadMotion.new()

var rs_up = InputEventJoypadMotion.new()
var rs_down = InputEventJoypadMotion.new()
var rs_left = InputEventJoypadMotion.new()
var rs_right = InputEventJoypadMotion.new()


var keyboard_up = InputEventKey.new()
var keyboard_down = InputEventKey.new()
var keyboard_left = InputEventKey.new()
var keyboard_right = InputEventKey.new()
var keyboard_taunt = InputEventKey.new()

var duplicate_detection_keyword: String

signal defaulted
signal duplicate_detected

func _ready():
	if !FileAccess.file_exists(INPUT_SETTINGS_FILE_PATH):
		create_inputs_file()
	
	if err == OK:
		pass
		#load_inputs()
		#load_keyboard_inputs()

func load_inputs() -> void:
	InputMap.action_erase_events("tiny_move_up")
	
	var keyboard_up_value = input_config.get_value("keybindings", "tiny_move_up")
	keyboard_up.keycode = OS.find_keycode_from_string(keyboard_up_value)
	InputMap.action_add_event("tiny_move_up", keyboard_up)
	
	controller_up.button_index = input_config.get_value("controller_bindings", 
	"tiny_move_up", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_up", controller_up)
	
	
	
	InputMap.action_erase_events("tiny_move_down")
	
	var keyboard_down_value = input_config.get_value("keybindings", "tiny_move_down")
	keyboard_down.keycode = OS.find_keycode_from_string(keyboard_down_value)
	InputMap.action_add_event("tiny_move_down", keyboard_down)
	
	controller_down.button_index = input_config.get_value("controller_bindings", 
	"tiny_move_down", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_down", controller_down)
	
	
	
	InputMap.action_erase_events("tiny_move_left")
	
	var keyboard_left_value = input_config.get_value("keybindings", "tiny_move_left")
	keyboard_left.keycode = OS.find_keycode_from_string(keyboard_left_value)
	InputMap.action_add_event("tiny_move_left", keyboard_left)
	
	controller_left.button_index = input_config.get_value("controller_bindings", 
	"tiny_move_left", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_left", controller_left)
	
	
	
	InputMap.action_erase_events("tiny_move_right")
	
	var keyboard_right_value = input_config.get_value("keybindings", "tiny_move_right")
	keyboard_right.keycode = OS.find_keycode_from_string(keyboard_right_value)
	InputMap.action_add_event("tiny_move_right", keyboard_right)
	
	controller_right.button_index = input_config.get_value("controller_bindings", 
	"tiny_move_right", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_right", controller_right)
	
	
	
	InputMap.action_erase_events("taunt")
	
	var keyboard_taunt_value = input_config.get_value("keybindings", "taunt")
	keyboard_taunt.keycode = OS.find_keycode_from_string(keyboard_taunt_value)
	InputMap.action_add_event("taunt", keyboard_taunt)
	
	controller_taunt.button_index = input_config.get_value("controller_bindings", 
	"taunt", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("taunt", controller_taunt)
	
	return


func create_inputs_file() -> void:
	print("input config file not found, or inputs reset. Creating input bindings file")
	
	input_config.set_value("keybindings", "tiny_move_up", "Up")
	input_config.set_value("keybindings", "tiny_move_down", "Down")
	input_config.set_value("keybindings", "tiny_move_left", "Left")
	input_config.set_value("keybindings", "tiny_move_right", "Right")
	input_config.set_value("keybindings", "taunt", "Space")
	
	input_config.set_value("controller_bindings", "tiny_move_up", 11)
	input_config.set_value("controller_bindings", "tiny_move_down", 12)
	input_config.set_value("controller_bindings", "tiny_move_left", 13)
	input_config.set_value("controller_bindings", "tiny_move_right", 14)
	input_config.set_value("controller_bindings", "taunt", 0)
	
	input_config.set_value("DEFAULT_BINDINGS_KEYS", "tiny_move_up", "Up")
	input_config.set_value("DEFAULT_BINDINGS_KEYS", "tiny_move_down", "Down")
	input_config.set_value("DEFAULT_BINDINGS_KEYS", "tiny_move_left", "Left")
	input_config.set_value("DEFAULT_BINDINGS_KEYS", "tiny_move_right", "Right")
	input_config.set_value("DEFAULT_BINDINGS_KEYS", "taunt", "Space")
	
	input_config.set_value("DEFAULT_BINDINGS_CONTROLLER", "tiny_move_up", 11)
	input_config.set_value("DEFAULT_BINDINGS_CONTROLLER", "tiny_move_down", 12)
	input_config.set_value("DEFAULT_BINDINGS_CONTROLLER", "tiny_move_left", 13)
	input_config.set_value("DEFAULT_BINDINGS_CONTROLLER", "tiny_move_right", 14)
	input_config.set_value("DEFAULT_BINDINGS_CONTROLLER", "taunt", 0)
	
	
	input_config.save(INPUT_SETTINGS_FILE_PATH)
	return

func reset_to_default_inputs() -> void:
	InputMap.action_erase_events("tiny_move_up")
	
	var keyboard_up_value = input_config.get_value("DEFAULT_BINDINGS_KEYS", "tiny_move_up")
	keyboard_up.keycode = OS.find_keycode_from_string(keyboard_up_value)
	InputMap.action_add_event("tiny_move_up", keyboard_up)
	
	controller_up.button_index = input_config.get_value("DEFAULT_BINDINGS_CONTROLLER", 
	"tiny_move_up", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_up", controller_up)
	
	
	
	InputMap.action_erase_events("tiny_move_down")
	
	var keyboard_down_value = input_config.get_value("DEFAULT_BINDINGS_KEYS", "tiny_move_down")
	keyboard_down.keycode = OS.find_keycode_from_string(keyboard_down_value)
	InputMap.action_add_event("tiny_move_down", keyboard_down)
	
	controller_down.button_index = input_config.get_value("DEFAULT_BINDINGS_CONTROLLER", 
	"tiny_move_down", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_down", controller_down)
	
	
	
	InputMap.action_erase_events("tiny_move_left")
	
	var keyboard_left_value = input_config.get_value("DEFAULT_BINDINGS_KEYS", "tiny_move_left")
	keyboard_left.keycode = OS.find_keycode_from_string(keyboard_left_value)
	InputMap.action_add_event("tiny_move_left", keyboard_left)
	
	controller_left.button_index = input_config.get_value("DEFAULT_BINDINGS_CONTROLLER", 
	"tiny_move_left", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_left", controller_left)
	
	
	
	InputMap.action_erase_events("tiny_move_right")
	
	var keyboard_right_value = input_config.get_value("DEFAULT_BINDINGS_KEYS", "tiny_move_right")
	keyboard_right.keycode = OS.find_keycode_from_string(keyboard_right_value)
	InputMap.action_add_event("tiny_move_right", keyboard_right)
	
	controller_right.button_index = input_config.get_value("DEFAULT_BINDINGS_CONTROLLER", 
	"tiny_move_right", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_right", controller_right)
	
	
	
	InputMap.action_erase_events("taunt")
	
	var keyboard_taunt_value = input_config.get_value("DEFAULT_BINDINGS_KEYS", "taunt")
	keyboard_taunt.keycode = OS.find_keycode_from_string(keyboard_taunt_value)
	InputMap.action_add_event("taunt", keyboard_taunt)
	
	controller_taunt.button_index = input_config.get_value("DEFAULT_BINDINGS_CONTROLLER", 
	"taunt", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("taunt", controller_taunt)
	
	create_inputs_file()
	
	defaulted.emit()
	return

@warning_ignore("unused_parameter")
func check_if_duplicates_keyboard(action_name: String, event: InputEvent) -> bool:
	pass
	var check_keyboard_up = input_config.get_value("keybindings", "tiny_move_up")
	var check_keyboard_down = input_config.get_value("keybindings", "tiny_move_down")
	var check_keyboard_left = input_config.get_value("keybindings", "tiny_move_left")
	var check_keyboard_right = input_config.get_value("keybindings", "tiny_move_right")
	var check_keyboard_taunt = input_config.get_value("keybindings", "taunt")
	
	var all_but_up_array = [check_keyboard_down, 
	check_keyboard_left, check_keyboard_right, check_keyboard_taunt]
	var all_but_down_array = [check_keyboard_up, 
	check_keyboard_left, check_keyboard_right, check_keyboard_taunt]
	var all_but_left_array = [check_keyboard_up, check_keyboard_down, 
	check_keyboard_right, check_keyboard_taunt]
	var all_but_right_array = [check_keyboard_up, check_keyboard_down, 
	check_keyboard_left, check_keyboard_taunt]
	var all_but_taunt_array = [check_keyboard_up, check_keyboard_down, 
	check_keyboard_left, check_keyboard_right]
	
	if action_name == "tiny_move_up":
		if input_config_keyboard_keycode in all_but_up_array:
			print("duplicate keyboard up input found")
			return true
		else:
			return false
	
	if action_name == "tiny_move_down":
		if input_config_keyboard_keycode in all_but_down_array:
			print("duplicate keyboard down input found")
			return true
		else:
			return false
	
	if action_name == "tiny_move_left":
		if input_config_keyboard_keycode in all_but_left_array:
			print("duplicate keyboard left input found")
			return true
		else:
			return false
	
	if action_name == "tiny_move_right":
		if input_config_keyboard_keycode in all_but_right_array:
			print("duplicate keyboard right input found")
			return true
		else:
			return false
	
	if action_name == "taunt":
		if input_config_keyboard_keycode in all_but_taunt_array:
			print("duplicate keyboard taunt input found")
			return true
		else:
			return false
	
	else:
		return false

@warning_ignore("unused_parameter")
func check_if_duplicates_controller(action_name: String, event: InputEvent) -> bool:
	pass
	var check_controller_up = input_config.get_value("controller_bindings", "tiny_move_up")
	var check_controller_down = input_config.get_value("controller_bindings", "tiny_move_down")
	var check_controller_left = input_config.get_value("controller_bindings", "tiny_move_left")
	var check_controller_right = input_config.get_value("controller_bindings", "tiny_move_right")
	var check_controller_taunt = input_config.get_value("controller_bindings", "taunt")
	#print(check_controller_up)
	#print(check_controller_down)
	#print(check_controller_left)
	#print(check_controller_right)
	#print(check_controller_taunt)
	#print(input_config_controller_button_index)
	
	var all_but_up_array = [check_controller_down, 
	check_controller_left, check_controller_right, check_controller_taunt]
	var all_but_down_array = [check_controller_up, 
	check_controller_left, check_controller_right, check_controller_taunt]
	var all_but_left_array = [check_controller_up, check_controller_down, 
	check_controller_right, check_controller_taunt]
	var all_but_right_array = [check_controller_up, check_controller_down, 
	check_controller_left, check_controller_taunt]
	var all_but_taunt_array = [check_controller_up, check_controller_down, 
	check_controller_left, check_controller_right]
	
	if action_name == "tiny_move_up":
		if input_config_controller_button_index in all_but_up_array:
			print("duplicate controller up input found")
			duplicate_detection_keyword = "dupe_up"
			return true
		else:
			return false
	
	if action_name == "tiny_move_down":
		if input_config_controller_button_index in all_but_down_array:
			print("duplicate controller down input found")
			duplicate_detection_keyword = "dupe_down"
			return true
		else:
			return false
	
	if action_name == "tiny_move_left":
		if input_config_controller_button_index in all_but_left_array:
			print("duplicate controller left input found")
			duplicate_detection_keyword = "dupe_left"
			return true
		else:
			return false
	
	if action_name == "tiny_move_right":
		if input_config_controller_button_index in all_but_right_array:
			print("duplicate controller right input found")
			duplicate_detection_keyword = "dupe_right"
			return true
		else:
			return false
	
	if action_name == "taunt":
		if input_config_controller_button_index in all_but_taunt_array:
			print("duplicate controller taunt input found")
			duplicate_detection_keyword = "dupe_taunt"
			return true
		else:
			return false
	
	else:
		return false


@warning_ignore("unused_parameter")
func save_keyboard_input(action_name: String, event: InputEvent, action_events_list: Array) -> void:
	print("keyboard keycode that was passed is: ", input_config_keyboard_keycode)
	
	var duplicate_return_value = check_if_duplicates_keyboard(action_name, event)
	print(duplicate_return_value)
	
	if duplicate_return_value == false:
		input_config.set_value("keybindings", action_name, input_config_keyboard_keycode)
		input_config.save(INPUT_SETTINGS_FILE_PATH)
	elif duplicate_return_value == true:
		duplicate_detected.emit()
		print("duplicate_detected emitted")
	return

@warning_ignore("unused_parameter")
func save_controller_input(action_name: String, event: InputEvent, action_events_list: Array) -> void:
	var duplicate_return_value = check_if_duplicates_controller(action_name, event)
	print(duplicate_return_value)
	
	if duplicate_return_value == false:
		input_config.set_value("controller_bindings", action_name, input_config_controller_button_index)
		input_config.save(INPUT_SETTINGS_FILE_PATH)
	elif duplicate_return_value == true:
		duplicate_detected.emit()
		print("duplicate_detected emitted")
	return
