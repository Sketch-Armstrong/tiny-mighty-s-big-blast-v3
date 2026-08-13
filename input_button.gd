extends Button
class_name InputRemapButton

const INPUT_SETTINGS_FILE_PATH = "user://input_settings.cfg"

@export var action: String
@export var action_event_index: int = 0
@export var action_axis_value: float = 0.0

@export var brute_force_input_label_controller_up: String

var text_left: String
var text_right: String

signal remapping
signal done_remapping

const CONTROLLER_BUTTON_LABELS: Dictionary = {
	JoyButton.JOY_BUTTON_A: "A",
		## key: value
			## experimenting a bit, JoyButton.JOY_BUTTON_A is just 0
			## these are enums, meaning they're just numbers, followed
			## by a corresponding string
	JoyButton.JOY_BUTTON_B: "B",
	JoyButton.JOY_BUTTON_X: "X",
	JoyButton.JOY_BUTTON_Y: "Y",
	JoyButton.JOY_BUTTON_LEFT_SHOULDER: "LB",
	JoyButton.JOY_BUTTON_RIGHT_SHOULDER: "RB",
	JoyButton.JOY_BUTTON_LEFT_STICK: "L3",
	JoyButton.JOY_BUTTON_RIGHT_STICK: "R3",
	JoyButton.JOY_BUTTON_DPAD_UP: "↑",
	JoyButton.JOY_BUTTON_DPAD_DOWN: "↓",
	JoyButton.JOY_BUTTON_DPAD_LEFT: "←",
	JoyButton.JOY_BUTTON_DPAD_RIGHT: "→",
	JoyButton.JOY_BUTTON_START: "Start",
	JoyButton.JOY_BUTTON_GUIDE: "Select",
}
const CONTROLLER_AXIS_LABELS: Dictionary = {
	"JoyAxis Left X": [JoyAxis.JOY_AXIS_LEFT_X],
	#JoyAxis.JOY_AXIS_LEFT_X: "left stick X",
	#JoyAxis.JOY_AXIS_LEFT_Y: "left stick Y",
	#JoyAxis.JOY_AXIS_RIGHT_X: "right stick X",
	#JoyAxis.JOY_AXIS_RIGHT_Y: "right stick Y",
	#JoyAxis.JOY_AXIS_TRIGGER_LEFT: "LT",
	#JoyAxis.JOY_AXIS_TRIGGER_RIGHT: "RT",
	
}
#
#● JOY_AXIS_LEFT_X = 
#Game controller left joystick x-axis.
#● JOY_AXIS_LEFT_Y = 1
#Game controller left joystick y-axis.
#● JOY_AXIS_RIGHT_X = 2
#Game controller right joystick x-axis.
#● JOY_AXIS_RIGHT_Y = 3
#Game controller right joystick y-axis.
#● JOY_AXIS_TRIGGER_LEFT = 4
#Game controller left trigger axis.
#● JOY_AXIS_TRIGGER_RIGHT = 5

var axis_reference_tester := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(CONTROLLER_AXIS_LABELS["JoyAxis Left X"])
	InputConfigHandler.defaulted.connect(reset_labels)
	InputConfigHandler.duplicate_detected.connect(undo_duplicate_label)
	toggle_mode = true
	_toggled(false)
	#reset_labels()
	#var check_controller_taunt = InputConfigHandler.input_config.get_value("controller_bindings", "taunt")
	#print(CONTROLLER_BUTTON_LABELS[check_controller_taunt])
	#if action == "tiny_move_up":
		#print("testing for filtering based on action string worked")
		## both this, and the preceding 2 lines, worked
	


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
	
	action_axis_value = Input.get_joy_axis(axis_reference_tester, JOY_AXIS_LEFT_X)
	print(str(CONTROLLER_AXIS_LABELS["JoyAxis Left X"]) + str(action_axis_value))
	#if action == "tiny_move_up":
		#print("testing for filtering based on action string worked")

func reset_labels() -> void:
	print("if this is printed when clicking RESET TO DEFAULT, it worked")
	if action == "tiny_move_up":
		text_left = "↑"
		text_right = "Up"
		text = text_left + text_right
	if action == "tiny_move_down":
		text_left = "↓"
		text_right = "Down"
		text = text_left + text_right
	if action == "tiny_move_left":
		text_left = "←"
		text_right = "Left"
		text = text_left + text_right
	if action == "tiny_move_right":
		text_left = "→"
		text_right = "Right"
		text = text_left + text_right
	if action == "taunt":
		text_left = "A"
		text_right = "Space"
		text = text_left + text_right
	
	else:
		return 

func undo_duplicate_label() -> void:
	if action == "tiny_move_up" && InputConfigHandler.duplicate_detection_keyword == "dupe_up":
		text = "Duplicate binding detected.\nRestoring previous binding"
	if action == "tiny_move_down" && InputConfigHandler.duplicate_detection_keyword == "dupe_down":
		text = "Duplicate binding detected.\nRestoring previous binding"
	if action == "tiny_move_left" && InputConfigHandler.duplicate_detection_keyword == "dupe_left":
		text = "Duplicate binding detected.\nRestoring previous binding"
	if action == "tiny_move_right" && InputConfigHandler.duplicate_detection_keyword == "dupe_right":
		text = "Duplicate binding detected.\nRestoring previous binding"
	if action == "taunt" && InputConfigHandler.duplicate_detection_keyword == "dupe_taunt":
		text = "Duplicate binding detected.\nRestoring previous binding"




func _toggled(toggled_on: bool) -> void:
	if !action or !InputMap.has_action(action):
		return
	
	if toggled_on == true:
		remapping.emit()
		print("remapping emitted")
		text = "Awaiting input"
		release_focus()
		return
	
	if action_event_index >= InputMap.action_get_events(action).size():
			# if the action_event_index's value is greater than (or equal to) the size of 
			# "action" (which was deriveed from using action_get_events to determine which 
			# event you were referring to in InputMap
		if action == "tiny_move_up":
			text = "testing for up"
			return
		if action == "tiny_move_down":
			text = "testing for down"
			return
		if action == "tiny_move_left":
			text = "testing for left"
			return
		if action == "tiny_move_right":
			text = "testing for right"
			return
		else:
			text = "Unassigned"
		return
	
	if action_event_index == 0:
		if action == "taunt":
			text = "testing for taunt"
			return

	
	var input = InputMap.action_get_events(action)[action_event_index]
		# the variable defined as "input" is equal to the specific action_event_index index, IN the 
		# action array. Which is derived from calling action_get_events to get the specified array
		# within the InputMap property, for the passed "action" parameter.
		# By default "action" is an empty String
	if input is InputEventJoypadButton:
		
		## I THINK if you feed the input.button_index or whatever, back into check_for_duplicates
		## you can prevent the text from getting overwritten? 
		## maybe there's a way to unga bunga it, by filtering and checking if input is
		print("this is the action print: ",str(action))
		
		if CONTROLLER_BUTTON_LABELS.has(input.button_index):
			text_left = CONTROLLER_BUTTON_LABELS.get(input.button_index)
			text = text_left + text_right
		else:
			text_left = "Button " + str(input.button_index)
			text = text_left + text_right

	
	elif input is InputEventKey:
		if input.physical_keycode != 0:
			text_right = OS.get_keycode_string(input.physical_keycode)
			text = text_left + text_right
		else:
			text_right = OS.get_keycode_string(input.keycode)
			text = text_left + text_right
				# both of these are just pulling a reference to the input, and setting the 
				# text of the input button, to the new input
	
	elif input is InputEventJoypadMotion:
		print("joypad motion printing")
	
	else:
		pass

func _unhandled_input(event: InputEvent) -> void:
	if !InputMap.has_action(action) or !is_pressed():
		return
	

	if event.is_pressed() and (event is InputEventKey or event is InputEventJoypadMotion or event is InputEventJoypadButton):
		var action_events_list = InputMap.action_get_events(action)
		if action_event_index < action_events_list.size():
			InputMap.action_erase_event(action, action_events_list[action_event_index])
		#InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)
		action_event_index = InputMap.action_get_events(action).size()-1
			## this is where inputs get changed
			
		
		button_pressed = false
		release_focus()

		if event is InputEventJoypadButton:
			InputConfigHandler.input_config_controller_button_index = event.button_index
			InputConfigHandler.save_controller_input(action, event, action_events_list)
			InputConfigHandler.load_inputs()
		elif event is InputEventKey:
			InputConfigHandler.input_config_keyboard_keycode = OS.get_keycode_string(event.physical_keycode)
			InputConfigHandler.save_keyboard_input(action, event, action_events_list)
			InputConfigHandler.load_inputs()
		elif event is InputEventJoypadMotion:
			print("joypad motion for _unhandled_input() passed")
			InputConfigHandler.input_config_controller_axis_index = event.axis
			print("axis was: ", InputConfigHandler.input_config_controller_axis_index)
		else:
			InputConfigHandler.input_config_keyboard_keycode = OS.get_keycode_string(event.keycode)
			InputConfigHandler.save_keyboard_input(action, event, action_events_list)
			InputConfigHandler.load_inputs()
		
		
		

		done_remapping.emit()
		return

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		button_pressed = false
		release_focus()
	## this function is just to release the focus upon mouse click
