extends Node

var input_config = ConfigFile.new()
var err = input_config.load("user://input_settings.cfg")
const INPUT_SETTINGS_FILE_PATH = "user://input_settings.cfg"


@export var action: String
@export var action_event_index: int = 0

var input_config_controller_button_index
var input_config_controller_axis_index
var input_config_controller_axis_deadzone_value := 0.5
var input_config_controller_axis_pos_or_neg := " "
var input_config_keyboard_keycode

var loading_values_test: Key

var controller_up_button = InputEventJoypadButton.new()
var controller_down_button = InputEventJoypadButton.new()
var controller_left_button = InputEventJoypadButton.new()
var controller_right_button = InputEventJoypadButton.new()
var controller_taunt_button = InputEventJoypadButton.new()

var controller_up_axis = InputEventJoypadMotion.new()
var controller_down_axis = InputEventJoypadMotion.new()
var controller_left_axis = InputEventJoypadMotion.new()
var controller_right_axis = InputEventJoypadMotion.new()
var controller_taunt_axis = InputEventJoypadMotion.new()

var keyboard_up = InputEventKey.new()
var keyboard_down = InputEventKey.new()
var keyboard_left = InputEventKey.new()
var keyboard_right = InputEventKey.new()
var keyboard_taunt = InputEventKey.new()

var keyboard_events := {
	"tiny_move_up": keyboard_up,
	"tiny_move_down": keyboard_down,
	"tiny_move_left": keyboard_left,
	"tiny_move_right": keyboard_right,
	"taunt": keyboard_taunt,
}
var controller_button_events := {
	"tiny_move_up": controller_up_button,
	"tiny_move_down": controller_down_button,
	"tiny_move_left": controller_left_button,
	"tiny_move_right": controller_right_button,
	"taunt": controller_taunt_button,
}
var controller_axis_events := {
	"tiny_move_up": controller_up_axis,
	"tiny_move_down": controller_down_axis,
	"tiny_move_left": controller_left_axis,
	"tiny_move_right": controller_right_axis,
	"taunt": controller_taunt_axis,
}


var duplicate_detection_keyword: String

signal defaulted
signal duplicate_detected

var button_or_axis := " "

var controller_input_identifier: int = 1
var controller_axis_strength: float = 1.0


var temp_testing_dictionary: Dictionary = {
	"first value": "one",
	"second value": "two",
	"mock axis values": [1, 0.5],
	"mock sub-dictionary": {
		"data_1": 1,
		"data_2": 2,
	}
}

const default_controller_inputs_dictionary: Dictionary = {
	"tiny_move_up": {
		"button, or axis?": "button",
		"button_information": 11,
		"axis_information": [1, "-0.5"],
	},
	"tiny_move_down": {
		"button, or axis?": "button",
		"button_information": 12,
		"axis_information": [1, "+0.5"],
	},
	"tiny_move_left": {
		"button, or axis?": "button",
		"button_information": 13,
		"axis_information": [0, "-0.5"],
	},
	"tiny_move_right": {
		"button, or axis?": "button",
		"button_information": 14,
		"axis_information": [0 , "+0.5"],
	},
	"taunt": {
		"button, or axis?": "button",
		"button_information": 0,
		"axis_information": [5, "+0.5"],
	},
}

var controller_inputs_dictionary: Dictionary 
	## mock dictionary should have one button, one axis, examples


#var temp_testing_dictionary_reading

func _ready():
	#create_inputs_file()
	sync_dictionary_to_config()
	#controller_inputs_dictionary["tiny_move_up"]["button, or axis?"] = "button"
	#input_config.set_value("DICTIONARY_TESTING_2", "SUB_HEADER_TESTING", controller_inputs_dictionary)
	#temp_testing_dictionary_reading = input_config.get_value("DICTIONARY_TESTING", 
	#"SUB_HEADER_TESTING", temp_testing_dictionary)
	##print("temp dictionary value pulled: ", temp_testing_dictionary_reading)
	#var temp_testing_dictionary_reading = input_config.get_value("DICTIONARY_TESTING", "SUB_HEADER_TESTING")
		## create a variable called temp_testing_dictionary_reading, set it equal to the input_config file's value 
		## within "DICTIONARY_TESTING", the value labeled "SUB_HEADER_TESTING"
	#var data_2_value = temp_testing_dictionary_reading["mock sub-dictionary"]["data_2"]
		## create a variable named data_2_value. Set it equal to the variable temp_testing_dictionary_reading (which is 
		## equal to the input_config's DICTIONARY_TESTING's value of "SUB_HEADER_TESTING")'s data entry labeled 
		## "mock sub-dictionary". Within "mock sub-dictionary" seek the data point labeled "data_2", and set the variable
		## named data_2_value equal to the data point labeled "data_2"
	##print("data_2 value: ", data_2_value)
		## print the string "data_2 value: ", and the previously defined data_2_value variable
	if !FileAccess.file_exists(INPUT_SETTINGS_FILE_PATH):
		create_inputs_file()
	
	if err == OK:
		pass
		load_inputs()
		#load_keyboard_inputs()
	#sync_dictionary_to_config()
	##print(controller_inputs_dictionary)
	

func create_inputs_file() -> void:
	#print("input config file not found, or inputs reset. Creating input bindings file")
	
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
	
	input_config.set_value("CONTROLLER_DICTIONARY", "BUTTON_AND_AXIS_VALUES", default_controller_inputs_dictionary)
	input_config.set_value("DEFAULT_DICTIONARY_CONTROLLER", "DEFAULT_BUTTON_AND_AXIS_VALUES", default_controller_inputs_dictionary)
	
	input_config.save(INPUT_SETTINGS_FILE_PATH)
	return

func load_inputs() -> void:
	InputMap.action_erase_events("tiny_move_up")
	
	var keyboard_up_value = input_config.get_value("keybindings", "tiny_move_up")
	keyboard_up.keycode = OS.find_keycode_from_string(keyboard_up_value)
	InputMap.action_add_event("tiny_move_up", keyboard_up)
	
	if controller_inputs_dictionary["tiny_move_up"]["button, or axis?"] == "button":
		controller_up_button.button_index = controller_inputs_dictionary["tiny_move_up"]["button_information"]
		InputMap.action_add_event("tiny_move_up", controller_up_button)
	elif controller_inputs_dictionary["tiny_move_up"]["button, or axis?"] == "axis":
		var up_axis_info = controller_inputs_dictionary["tiny_move_up"]["axis_information"]
		controller_up_axis.axis = up_axis_info[0]
		controller_up_axis.axis_value = float(up_axis_info[1])
		InputMap.action_add_event("tiny_move_up", controller_up_axis)
	
	
	InputMap.action_erase_events("tiny_move_down")
		
	var keyboard_down_value = input_config.get_value("keybindings", "tiny_move_down")
	keyboard_down.keycode = OS.find_keycode_from_string(keyboard_down_value)
	InputMap.action_add_event("tiny_move_down", keyboard_down)
	
	if controller_inputs_dictionary["tiny_move_down"]["button, or axis?"] == "button":
		controller_down_button.button_index = controller_inputs_dictionary["tiny_move_down"]["button_information"]
		InputMap.action_add_event("tiny_move_down", controller_down_button)
	
	elif controller_inputs_dictionary["tiny_move_down"]["button, or axis?"] == "axis":
		var down_axis_info = controller_inputs_dictionary["tiny_move_down"]["axis_information"]
		controller_down_axis.axis = down_axis_info[0]
		controller_down_axis.axis_value = float(down_axis_info[1])
		InputMap.action_add_event("tiny_move_down", controller_down_axis)
	
	
	
	InputMap.action_erase_events("tiny_move_left")
	
	var keyboard_left_value = input_config.get_value("keybindings", "tiny_move_left")
	keyboard_left.keycode = OS.find_keycode_from_string(keyboard_left_value)
	InputMap.action_add_event("tiny_move_left", keyboard_left)
	
	
	if controller_inputs_dictionary["tiny_move_left"]["button, or axis?"] == "button":
		controller_left_button.button_index = controller_inputs_dictionary["tiny_move_left"]["button_information"]
		InputMap.action_add_event("tiny_move_left", controller_left_button)
	
	elif controller_inputs_dictionary["tiny_move_left"]["button, or axis?"] == "axis":
		var left_axis_info = controller_inputs_dictionary["tiny_move_left"]["axis_information"]
		controller_left_axis.axis = left_axis_info[0]
		controller_left_axis.axis_value = float(left_axis_info[1])
		InputMap.action_add_event("tiny_move_left", controller_left_axis)
	
	
	InputMap.action_erase_events("tiny_move_right")
	
	var keyboard_right_value = input_config.get_value("keybindings", "tiny_move_right")
	keyboard_right.keycode = OS.find_keycode_from_string(keyboard_right_value)
	InputMap.action_add_event("tiny_move_right", keyboard_right)
	
	
	if controller_inputs_dictionary["tiny_move_right"]["button, or axis?"] == "button":
		controller_right_button.button_index = controller_inputs_dictionary["tiny_move_right"]["button_information"]
		InputMap.action_add_event("tiny_move_right", controller_right_button)
	
	elif controller_inputs_dictionary["tiny_move_right"]["button, or axis?"] == "axis":
		var right_axis_info = controller_inputs_dictionary["tiny_move_right"]["axis_information"]
		controller_right_axis.axis = right_axis_info[0]
		controller_right_axis.axis_value = float(right_axis_info[1])
		InputMap.action_add_event("tiny_move_right", controller_right_axis)
	
	
	InputMap.action_erase_events("taunt")
	
	var keyboard_taunt_value = input_config.get_value("keybindings", "taunt")
	keyboard_taunt.keycode = OS.find_keycode_from_string(keyboard_taunt_value)
	InputMap.action_add_event("taunt", keyboard_taunt)
	
	if controller_inputs_dictionary["taunt"]["button, or axis?"] == "button":
		controller_taunt_button.button_index = controller_inputs_dictionary["taunt"]["button_information"]
		InputMap.action_add_event("taunt", controller_taunt_button)
	
	elif controller_inputs_dictionary["taunt"]["button, or axis?"] == "button":
		var taunt_axis_info = controller_inputs_dictionary["taunt"]["axis_information"]
		controller_taunt_axis.axis = taunt_axis_info[0]
		controller_taunt_axis.axis_value = float(taunt_axis_info[1])
		InputMap.action_add_event("taunt", controller_taunt_axis)
	#input_config.set_value("DICTIONARY_TESTING", "SUB_HEADER_TESTING", default_controller_inputs_dictionary)
	return




func reset_to_default_inputs() -> void:
	set_dictionary_to_default()
	InputMap.action_erase_events("tiny_move_up")
	
	var keyboard_up_value = input_config.get_value("DEFAULT_BINDINGS_KEYS", "tiny_move_up")
	keyboard_up.keycode = OS.find_keycode_from_string(keyboard_up_value)
	InputMap.action_add_event("tiny_move_up", keyboard_up)
	
	controller_up_button.button_index = input_config.get_value("DEFAULT_BINDINGS_CONTROLLER", 
	"tiny_move_up", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_up", controller_up_button)
	
	var up_axis_info = controller_inputs_dictionary["tiny_move_up"]["axis_information"]
	controller_up_axis.axis = up_axis_info[0]
	controller_up_axis.axis_value = float(up_axis_info[1])
	InputMap.action_add_event("tiny_move_up", controller_up_axis)
	
	
	
	
	InputMap.action_erase_events("tiny_move_down")
	
	var keyboard_down_value = input_config.get_value("DEFAULT_BINDINGS_KEYS", "tiny_move_down")
	keyboard_down.keycode = OS.find_keycode_from_string(keyboard_down_value)
	InputMap.action_add_event("tiny_move_down", keyboard_down)
	
	controller_down_button.button_index = input_config.get_value("DEFAULT_BINDINGS_CONTROLLER", 
	"tiny_move_down", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_down", controller_down_button)
	
	var down_axis_info = controller_inputs_dictionary["tiny_move_down"]["axis_information"]
	controller_down_axis.axis = down_axis_info[0]
	controller_down_axis.axis_value = float(down_axis_info[1])
	InputMap.action_add_event("tiny_move_down", controller_down_axis)
	
	
	InputMap.action_erase_events("tiny_move_left")
	
	var keyboard_left_value = input_config.get_value("DEFAULT_BINDINGS_KEYS", "tiny_move_left")
	keyboard_left.keycode = OS.find_keycode_from_string(keyboard_left_value)
	InputMap.action_add_event("tiny_move_left", keyboard_left)
	
	controller_left_button.button_index = input_config.get_value("DEFAULT_BINDINGS_CONTROLLER", 
	"tiny_move_left", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_left", controller_left_button)
	
	var left_axis_info = controller_inputs_dictionary["tiny_move_left"]["axis_information"]
	controller_left_axis.axis = left_axis_info[0]
	controller_left_axis.axis_value = float(left_axis_info[1])
	InputMap.action_add_event("tiny_move_left", controller_left_axis)
	
	InputMap.action_erase_events("tiny_move_right")
	
	var keyboard_right_value = input_config.get_value("DEFAULT_BINDINGS_KEYS", "tiny_move_right")
	keyboard_right.keycode = OS.find_keycode_from_string(keyboard_right_value)
	InputMap.action_add_event("tiny_move_right", keyboard_right)
	
	controller_right_button.button_index = input_config.get_value("DEFAULT_BINDINGS_CONTROLLER", 
	"tiny_move_right", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("tiny_move_right", controller_right_button)
	
	var right_axis_info = controller_inputs_dictionary["tiny_move_right"]["axis_information"]
	controller_right_axis.axis = right_axis_info[0]
	controller_right_axis.axis_value = float(right_axis_info[1])
	InputMap.action_add_event("tiny_move_right", controller_right_axis)
	
	
	InputMap.action_erase_events("taunt")
	
	var keyboard_taunt_value = input_config.get_value("DEFAULT_BINDINGS_KEYS", "taunt")
	keyboard_taunt.keycode = OS.find_keycode_from_string(keyboard_taunt_value)
	InputMap.action_add_event("taunt", keyboard_taunt)
	
	controller_taunt_button.button_index = input_config.get_value("DEFAULT_BINDINGS_CONTROLLER", 
	"taunt", "FAILSAFE NULL VALUE")
	InputMap.action_add_event("taunt", controller_taunt_button)
	
	var taunt_axis_info = controller_inputs_dictionary["taunt"]["axis_information"]
	controller_taunt_axis.axis = taunt_axis_info[0]
	controller_taunt_axis.axis_value = float(taunt_axis_info[1])
	InputMap.action_add_event("taunt", controller_taunt_axis)
	
	create_inputs_file()
	
	print("synced to config dictionary was: ", controller_inputs_dictionary)
	
	defaulted.emit()
	return

func sync_dictionary_to_config() -> void:
	controller_inputs_dictionary = input_config.get_value("CONTROLLER_DICTIONARY", "BUTTON_AND_AXIS_VALUES").duplicate(true)
	return

func set_dictionary_to_default() -> void:
	controller_inputs_dictionary = input_config.get_value("DEFAULT_DICTIONARY_CONTROLLER", "DEFAULT_BUTTON_AND_AXIS_VALUES").duplicate(true)


func sync_config_to_dictionary() -> void:
	input_config.set_value("CONTROLLER_DICTIONARY", "BUTTON_AND_AXIS_VALUES", controller_inputs_dictionary)
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
			#print("duplicate keyboard up input found")
			return true
		else:
			return false
	
	if action_name == "tiny_move_down":
		if input_config_keyboard_keycode in all_but_down_array:
			#print("duplicate keyboard down input found")
			return true
		else:
			return false
	
	if action_name == "tiny_move_left":
		if input_config_keyboard_keycode in all_but_left_array:
			#print("duplicate keyboard left input found")
			return true
		else:
			return false
	
	if action_name == "tiny_move_right":
		if input_config_keyboard_keycode in all_but_right_array:
			#print("duplicate keyboard right input found")
			return true
		else:
			return false
	
	if action_name == "taunt":
		if input_config_keyboard_keycode in all_but_taunt_array:
			#print("duplicate keyboard taunt input found")
			return true
		else:
			return false
	
	else:
		return false

@warning_ignore("unused_parameter")
func check_if_duplicates_controller(action_name: String, event: InputEvent) -> bool:
	pass
	sync_dictionary_to_config()
	var input_config_controller_axis_direction = input_config_controller_axis_pos_or_neg + str(input_config_controller_axis_deadzone_value)
	var input_config_controller_axis_both: Array = [input_config_controller_axis_index, input_config_controller_axis_direction]
	
	
	var check_controller_up_button
	var check_controller_down_button
	var check_controller_left_button
	var check_controller_right_button
	var check_controller_taunt_button
	
	var check_controller_up_axis
	var check_controller_up_axis_value
	
	var check_controller_down_axis
	var check_controller_down_axis_value
	
	var check_controller_left_axis
	var check_controller_left_axis_value
	
	var check_controller_right_axis
	var check_controller_right_axis_value
	
	var check_controller_taunt_axis
	var check_controller_taunt_axis_value
	
	check_controller_up_button = controller_inputs_dictionary["tiny_move_up"]["button_information"]
	check_controller_down_button = controller_inputs_dictionary["tiny_move_down"]["button_information"]
	check_controller_left_button = controller_inputs_dictionary["tiny_move_left"]["button_information"]
	check_controller_right_button = controller_inputs_dictionary["tiny_move_right"]["button_information"]
	check_controller_taunt_button = controller_inputs_dictionary["taunt"]["button_information"]
	
	check_controller_up_axis = controller_inputs_dictionary["tiny_move_up"]["axis_information"][0]
	check_controller_up_axis_value = controller_inputs_dictionary["tiny_move_up"]["axis_information"][1]
	
	check_controller_down_axis = controller_inputs_dictionary["tiny_move_down"]["axis_information"][0]
	check_controller_down_axis_value = controller_inputs_dictionary["tiny_move_down"]["axis_information"][1]
	check_controller_left_axis = controller_inputs_dictionary["tiny_move_left"]["axis_information"][0]
	check_controller_left_axis_value = controller_inputs_dictionary["tiny_move_left"]["axis_information"][1]
	check_controller_right_axis = controller_inputs_dictionary["tiny_move_right"]["axis_information"][0]
	check_controller_right_axis_value = controller_inputs_dictionary["tiny_move_right"]["axis_information"][1]
	check_controller_taunt_axis = controller_inputs_dictionary["taunt"]["axis_information"][0]
	check_controller_taunt_axis_value = controller_inputs_dictionary["taunt"]["axis_information"][1]
	print("check controller taunt axis was: ",check_controller_taunt_axis)
	print("check controller taunt axis value was: ",check_controller_taunt_axis_value)
	#print("check_controller_up_button (for axis) was: ", str(controller_inputs_dictionary["tiny_move_up"]["button, or axis?"]))
	var check_controller_right_axis_both: Array = [check_controller_right_axis, check_controller_right_axis_value]
	var check_controller_left_axis_both: Array = [check_controller_left_axis, check_controller_left_axis_value]
	var check_controller_down_axis_both: Array = [check_controller_down_axis, check_controller_down_axis_value]
	var check_controller_up_axis_both: Array = [check_controller_up_axis, check_controller_up_axis_value]
	
	var check_controller_taunt_axis_both: Array = [check_controller_taunt_axis, check_controller_taunt_axis_value]
	
	var all_but_up_array = [check_controller_down_button, check_controller_left_button, check_controller_right_button, check_controller_taunt_button]
	var all_but_down_array = [check_controller_up_button, check_controller_left_button, check_controller_right_button, check_controller_taunt_button]
	var all_but_left_array = [check_controller_up_button, check_controller_down_button, check_controller_right_button, check_controller_taunt_button]
	var all_but_right_array = [check_controller_up_button, check_controller_down_button,check_controller_left_button, check_controller_taunt_button]
	var all_but_taunt_array = [check_controller_up_button, check_controller_down_button, check_controller_left_button, check_controller_right_button]
	
	
	var all_but_up_array_axis = [check_controller_down_axis_both, check_controller_left_axis_both, check_controller_right_axis_both, check_controller_taunt_axis_both]
	var all_but_down_array_axis = [check_controller_up_axis_both, check_controller_left_axis_both, check_controller_right_axis_both, check_controller_taunt_axis_both]
	var all_but_left_array_axis = [check_controller_up_axis_both, check_controller_down_axis_both, check_controller_right_axis_both, check_controller_taunt_axis_both]
	var all_but_right_array_axis = [check_controller_up_axis_both, check_controller_down_axis_both, check_controller_left_axis_both, check_controller_taunt_axis_both]
	var all_but_taunt_array_axis = [check_controller_up_axis_both, check_controller_down_axis_both, check_controller_left_axis_both, check_controller_right_axis_both]
	
	if event is InputEventJoypadButton:
		if action_name == "tiny_move_up":
			if input_config_controller_button_index in all_but_up_array:
				#print("duplicate controller up input IN DICTIONARY found")
				duplicate_detection_keyword = "dupe_up"
				return true
			else:
				return false
		
		if action_name == "tiny_move_down":
			if input_config_controller_button_index in all_but_down_array:
				#print("duplicate controller down input IN DICTIONARY found")
				duplicate_detection_keyword = "dupe_down"
				return true
			else:
				return false
		
		if action_name == "tiny_move_left":
			if input_config_controller_button_index in all_but_left_array:
				#print("duplicate controller left input IN DICTIONARY found")
				duplicate_detection_keyword = "dupe_left"
				return true
			else:
				return false
		
		if action_name == "tiny_move_right":
			if input_config_controller_button_index in all_but_right_array:
				#print("duplicate controller right input IN DICTIONARY found")
				duplicate_detection_keyword = "dupe_right"
				return true
			else:
				return false
		
		if action_name == "taunt":
			if input_config_controller_button_index in all_but_taunt_array:
				#print("duplicate controller taunt input IN DICTIONARY found")
				duplicate_detection_keyword = "dupe_taunt"
				return true
			else:
				return false
	
	
	if event is InputEventJoypadMotion:
		if action_name == "tiny_move_up":
			if input_config_controller_axis_both in all_but_up_array_axis:
				#print("duplicate controller up input IN DICTIONARY found")
				duplicate_detection_keyword = "dupe_up"
				return true
			else:
				return false
		
		if action_name == "tiny_move_down":
			if input_config_controller_axis_both in all_but_down_array_axis:
				#print("duplicate controller up input IN DICTIONARY found")
				duplicate_detection_keyword = "dupe_down"
				return true
			else:
				return false
		
		if action_name == "tiny_move_left":
			if input_config_controller_axis_both in all_but_left_array_axis:
				#print("duplicate controller up input IN DICTIONARY found")
				duplicate_detection_keyword = "dupe_left"
				return true
			else:
				return false
		
		if action_name == "tiny_move_right":
			if input_config_controller_axis_both in all_but_right_array_axis:
				#print("duplicate controller up input IN DICTIONARY found")
				duplicate_detection_keyword = "dupe_right"
				return true
			else:
				return false
		
		if action_name == "taunt":
			if input_config_controller_axis_both in all_but_taunt_array_axis:
				#print("duplicate controller up input IN DICTIONARY found")
				duplicate_detection_keyword = "dupe_taunt"
				return true
			else:
				return false
	
	else:
		return false
	
	return false




@warning_ignore("unused_parameter")
@warning_ignore("unused_parameter")
func save_keyboard_input(action_name: String, event: InputEvent, action_events_list: Array) -> void:
	var duplicate_return_value = check_if_duplicates_keyboard(action_name, event)
	
	if duplicate_return_value == false:
		input_config.set_value("keybindings", action_name, input_config_keyboard_keycode)
		input_config.save(INPUT_SETTINGS_FILE_PATH)
		
		var key_event: InputEventKey = keyboard_events[action_name]
		InputMap.action_erase_event(action_name, key_event)
		key_event.keycode = OS.find_keycode_from_string(input_config_keyboard_keycode)
		InputMap.action_add_event(action_name, key_event)
	elif duplicate_return_value == true:
		duplicate_detected.emit()
	return

@warning_ignore("unused_parameter")
func save_controller_input(action_name: String, event: InputEvent, action_events_list: Array) -> void:
	var duplicate_return_value = check_if_duplicates_controller(action_name, event)
	
	
	if duplicate_return_value == false:
		if event is InputEventJoypadButton:
			save_controller_input_button(action_name, event, action_events_list)
			input_config.save(INPUT_SETTINGS_FILE_PATH)
		elif event is InputEventJoypadMotion:
			save_controller_input_axis(action_name, event, action_events_list)
			input_config.save(INPUT_SETTINGS_FILE_PATH)
	elif duplicate_return_value == true:
		duplicate_detected.emit()

	return

@warning_ignore("unused_parameter")
@warning_ignore("unused_parameter")
func save_controller_input_button(action_name: String, event: InputEvent, action_events_list: Array) -> void:
	controller_inputs_dictionary[action_name]["button, or axis?"] = "button"
	controller_inputs_dictionary[action_name]["button_information"] = input_config_controller_button_index
	input_config.set_value("CONTROLLER_DICTIONARY", "BUTTON_AND_AXIS_VALUES", controller_inputs_dictionary)
	
	var button_event: InputEventJoypadButton = controller_button_events[action_name]
	InputMap.action_erase_event(action_name, button_event)
	button_event.button_index = input_config_controller_button_index
	InputMap.action_add_event(action_name, button_event)
	return

@warning_ignore("unused_parameter")
func save_controller_input_axis(action_name: String, event: InputEvent, action_events_list: Array) -> void:
	controller_inputs_dictionary[action_name]["button, or axis?"] = "axis"
	controller_inputs_dictionary[action_name]["axis_information"] = [input_config_controller_axis_index, 
	str(input_config_controller_axis_pos_or_neg + str(input_config_controller_axis_deadzone_value))]
	input_config.set_value("CONTROLLER_DICTIONARY", "BUTTON_AND_AXIS_VALUES", controller_inputs_dictionary)
	
	var axis_event: InputEventJoypadMotion = controller_axis_events[action_name]
	InputMap.action_erase_event(action_name, axis_event)
	axis_event.axis = input_config_controller_axis_index
	axis_event.axis_value = input_config_controller_axis_deadzone_value * (1.0 if input_config_controller_axis_pos_or_neg == "+" else -1.0)
	InputMap.action_add_event(action_name, axis_event)
	return
