extends Button
class_name InputRemapButton

const INPUT_SETTINGS_FILE_PATH = "user://input_settings.cfg"

@export var action: String
#@export var action_event_index: int = 0
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
	JoyAxis.JOY_AXIS_LEFT_X: {-1: "left stick ←", 1: "left stick →"},
	JoyAxis.JOY_AXIS_LEFT_Y: {-1: "left stick ↑", 1: "left stick ↓"},
	JoyAxis.JOY_AXIS_RIGHT_X: {-1: "right stick ←", 1: "right stick →"},
	JoyAxis.JOY_AXIS_RIGHT_Y: {-1: "right stick ↑", 1: "right stick ↓"},
	JoyAxis.JOY_AXIS_TRIGGER_LEFT: {1: "LT"},
	JoyAxis.JOY_AXIS_TRIGGER_RIGHT: {1: "RT"},
	
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
	print("joyaxis printing was: ", CONTROLLER_AXIS_LABELS["JoyAxis Left X"])
	InputConfigHandler.defaulted.connect(refresh_label)
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
	#print(str(CONTROLLER_AXIS_LABELS["JoyAxis Left X"]) + str(action_axis_value))
	#if action == "tiny_move_up":
		#print("testing for filtering based on action string worked")



func refresh_label() -> void:
	if !action or !InputMap.has_action(action):
		return
	var left := "Unassigned"
	var right := "Unassigned"
	for event in InputMap.action_get_events(action):
		if event is InputEventJoypadButton:
			left = CONTROLLER_BUTTON_LABELS.get(event.button_index, "Button " + str(event.button_index))
		elif event is InputEventJoypadMotion:
			left = get_axis_label(event.axis, event.axis_value)
		elif event is InputEventKey:
			var code = event.physical_keycode if event.physical_keycode != 0 else event.keycode
			right = OS.get_keycode_string(code)
	text_left = left
	text_right = right
	text = text_left + "    " + text_right

func undo_duplicate_label() -> void:
	if action == "tiny_move_up" && InputConfigHandler.duplicate_detection_keyword == "dupe_up":
		text = "Duplicate input\nnot saved"
	if action == "tiny_move_down" && InputConfigHandler.duplicate_detection_keyword == "dupe_down":
		text = "Duplicate input\nnot saved"
	if action == "tiny_move_left" && InputConfigHandler.duplicate_detection_keyword == "dupe_left":
		text = "Duplicate input\nnot saved"
	if action == "tiny_move_right" && InputConfigHandler.duplicate_detection_keyword == "dupe_right":
		text = "Duplicate input\nnot saved"
	if action == "taunt" && InputConfigHandler.duplicate_detection_keyword == "dupe_taunt":
		text = "Duplicate input\nnot saved"




func _toggled(toggled_on: bool) -> void:
	if !action or !InputMap.has_action(action):
		return
	if toggled_on:
		remapping.emit()
		text = "Awaiting input"
		release_focus()
		return
	refresh_label()
	



func get_axis_label(axis: JoyAxis, value: float, deadzone: float = 0.2) -> String:
	if not CONTROLLER_AXIS_LABELS.has(axis):
		return "unknown axis"
	if absf(value) < deadzone:
		return "input did not breach deadzone. Try again."
	var sign_key := 1 if value > 0 else -1
	#explanation:
	#var sign_key: int
	#if value > 0:
		#sign_key = 1
	#if value < 0:
		#sign_key = -1
	return CONTROLLER_AXIS_LABELS[axis].get(sign_key, "Unknown direction")




func _unhandled_input(event: InputEvent) -> void:
	if !InputMap.has_action(action) or !is_pressed():
		return
	if not event.is_pressed():
		return
	if not (event is InputEventKey or event is InputEventJoypadButton or event is InputEventJoypadMotion):
		return

	var action_events_list = InputMap.action_get_events(action)
	var saved := false

	button_pressed = false
	release_focus()

	if event is InputEventJoypadButton:
		InputConfigHandler.button_or_axis = "button"
		InputConfigHandler.input_config_controller_button_index = event.button_index
		saved = InputConfigHandler.save_controller_input(action, event, action_events_list)
	elif event is InputEventJoypadMotion:
		InputConfigHandler.button_or_axis = "axis"
		InputConfigHandler.input_config_controller_axis_index = event.axis
		InputConfigHandler.input_config_controller_axis_pos_or_neg = "+" if event.axis_value > 0 else "-"
		saved = InputConfigHandler.save_controller_input(action, event, action_events_list)
	elif event is InputEventKey:
		InputConfigHandler.input_config_keyboard_keycode = OS.get_keycode_string(event.physical_keycode)
		saved = InputConfigHandler.save_keyboard_input(action, event, action_events_list)

	InputConfigHandler.load_inputs()
	if saved:
		refresh_label()
	done_remapping.emit()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		button_pressed = false
		release_focus()
	## this function is just to release the focus upon mouse click
