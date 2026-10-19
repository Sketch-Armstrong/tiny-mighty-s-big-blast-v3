extends Button
class_name InputRemapButton

const INPUT_SETTINGS_FILE_PATH = "user://input_settings.cfg"

@export var action: String
#@export var action_event_index: int = 0
@export var action_axis_value: float = 0.0

static var controller_identity := ""

var text_left: String
var text_right: String

signal remapping
signal done_remapping

const VENDOR_HEX_MICROSOFT := 0x045E
const VENDOR_HEX_SONY := 0x054C
const VENDOR_HEX_NINTENDO := 0x057E
const VENDOR_8BITDO := 0x2DC8



const CONTROLLER_BUTTON_LABELS_XBOX: Dictionary = {
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
	JoyButton.JOY_BUTTON_DPAD_UP: "D-Pad ↑",
	JoyButton.JOY_BUTTON_DPAD_DOWN: "D-Pad ↓",
	JoyButton.JOY_BUTTON_DPAD_LEFT: "D-Pad ←",
	JoyButton.JOY_BUTTON_DPAD_RIGHT: "D-Pad →",
	JoyButton.JOY_BUTTON_START: "Start",
	JoyButton.JOY_BUTTON_GUIDE: "Select",
}

const CONTROLLER_BUTTON_LABELS_SONY: Dictionary = {
	JoyButton.JOY_BUTTON_A: "⤫",
		## key: value
			## experimenting a bit, JoyButton.JOY_BUTTON_A is just 0
			## these are enums, meaning they're just numbers, followed
			## by a corresponding string
	JoyButton.JOY_BUTTON_B: "◯",
	JoyButton.JOY_BUTTON_X: "◻",
	JoyButton.JOY_BUTTON_Y: "△",
	JoyButton.JOY_BUTTON_LEFT_SHOULDER: "L2",
	JoyButton.JOY_BUTTON_RIGHT_SHOULDER: "R2",
	JoyButton.JOY_BUTTON_LEFT_STICK: "L3",
	JoyButton.JOY_BUTTON_RIGHT_STICK: "R3",
	JoyButton.JOY_BUTTON_DPAD_UP: "D-Pad ↑",
	JoyButton.JOY_BUTTON_DPAD_DOWN: "D-Pad ↓",
	JoyButton.JOY_BUTTON_DPAD_LEFT: "D-Pad ←",
	JoyButton.JOY_BUTTON_DPAD_RIGHT: "D-Pad →",
	JoyButton.JOY_BUTTON_START: "Start",
	JoyButton.JOY_BUTTON_GUIDE: "Select",
}

const CONTROLLER_BUTTON_LABELS_NINTENDO: Dictionary = {
	JoyButton.JOY_BUTTON_A: "B",
		## key: value
			## experimenting a bit, JoyButton.JOY_BUTTON_A is just 0
			## these are enums, meaning they're just numbers, followed
			## by a corresponding string
	JoyButton.JOY_BUTTON_B: "A",
	JoyButton.JOY_BUTTON_X: "Y",
	JoyButton.JOY_BUTTON_Y: "X",
	JoyButton.JOY_BUTTON_LEFT_SHOULDER: "L",
	JoyButton.JOY_BUTTON_RIGHT_SHOULDER: "R",
	JoyButton.JOY_BUTTON_LEFT_STICK: "L3",
	JoyButton.JOY_BUTTON_RIGHT_STICK: "R3",
	JoyButton.JOY_BUTTON_DPAD_UP: "D-Pad ↑",
	JoyButton.JOY_BUTTON_DPAD_DOWN: "D-Pad ↓",
	JoyButton.JOY_BUTTON_DPAD_LEFT: "D-Pad ←",
	JoyButton.JOY_BUTTON_DPAD_RIGHT: "D-Pad →",
	JoyButton.JOY_BUTTON_START: "Start",
	JoyButton.JOY_BUTTON_GUIDE: "Select",
}

const CONTROLLER_AXIS_LABELS_XBOX: Dictionary = {
	"JoyAxis Left X": [JoyAxis.JOY_AXIS_LEFT_X],
	JoyAxis.JOY_AXIS_LEFT_X: {-1: "Left Stick ←", 1: "Left Stick →"},
	JoyAxis.JOY_AXIS_LEFT_Y: {-1: "Left Stick ↑", 1: "Left Stick ↓"},
	JoyAxis.JOY_AXIS_RIGHT_X: {-1: "Right Stick ←", 1: "Right Stick →"},
	JoyAxis.JOY_AXIS_RIGHT_Y: {-1: "Right Stick ↑", 1: "Right Stick ↓"},
	JoyAxis.JOY_AXIS_TRIGGER_LEFT: {1: "LT"},
	JoyAxis.JOY_AXIS_TRIGGER_RIGHT: {1: "RT"},
	
}

const CONTROLLER_AXIS_LABELS_SONY: Dictionary = {
	"JoyAxis Left X": [JoyAxis.JOY_AXIS_LEFT_X],
	JoyAxis.JOY_AXIS_LEFT_X: {-1: "Left Stick ←", 1: "Left Stick →"},
	JoyAxis.JOY_AXIS_LEFT_Y: {-1: "Left Stick ↑", 1: "Left Stick ↓"},
	JoyAxis.JOY_AXIS_RIGHT_X: {-1: "Right Stick ←", 1: "Right Stick →"},
	JoyAxis.JOY_AXIS_RIGHT_Y: {-1: "Right Stick ↑", 1: "Right Stick ↓"},
	JoyAxis.JOY_AXIS_TRIGGER_LEFT: {1: "L2"},
	JoyAxis.JOY_AXIS_TRIGGER_RIGHT: {1: "R2"},
	
}

const CONTROLLER_AXIS_LABELS_NINTENDO: Dictionary = {
	"JoyAxis Left X": [JoyAxis.JOY_AXIS_LEFT_X],
	JoyAxis.JOY_AXIS_LEFT_X: {-1: "Left Stick ←", 1: "Left Stick →"},
	JoyAxis.JOY_AXIS_LEFT_Y: {-1: "Left Stick ↑", 1: "Left Stick ↓"},
	JoyAxis.JOY_AXIS_RIGHT_X: {-1: "Right Stick ←", 1: "Right Stick →"},
	JoyAxis.JOY_AXIS_RIGHT_Y: {-1: "Right Stick ↑", 1: "Right Stick ↓"},
	JoyAxis.JOY_AXIS_TRIGGER_LEFT: {1: "ZL"},
	JoyAxis.JOY_AXIS_TRIGGER_RIGHT: {1: "ZR"},
	
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

#var axis_reference_tester := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var total_connected_controllers := Input.get_connected_joypads()
	if total_connected_controllers.size() > 0:
		identify_controller_type(total_connected_controllers[0])
	print("joyaxis printing was: ", CONTROLLER_AXIS_LABELS_XBOX["JoyAxis Left X"])
	InputConfigHandler.defaulted.connect(refresh_label)
	InputConfigHandler.duplicate_detected.connect(undo_duplicate_label)
	InputConfigHandler.controller_type_changed.connect(refresh_label)
	
	Input.joy_connection_changed.connect(_on_controller_connection_changed)
	toggle_mode = true
	_toggled(false)
	#reset_labels()
	#var check_controller_taunt = InputConfigHandler.input_config.get_value("controller_bindings", "taunt")
	#print(CONTROLLER_BUTTON_LABELS_XBOX[check_controller_taunt])
	#if action == "tiny_move_up":
		#print("testing for filtering based on action string worked")
		## both this, and the preceding 2 lines, worked


func _on_controller_connection_changed(device: int, connected: bool) -> void:
	if connected:
		identify_controller_type(device)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
	
	#action_axis_value = Input.get_joy_axis(axis_reference_tester, JOY_AXIS_LEFT_X)
	#print(str(CONTROLLER_AXIS_LABELS_XBOX["JoyAxis Left X"]) + str(action_axis_value))
	#if action == "tiny_move_up":
		#print("testing for filtering based on action string worked")


func get_button_labels(button_index: int) -> String:
	var labels := CONTROLLER_BUTTON_LABELS_XBOX
	match controller_identity:
		"sony":
			labels = CONTROLLER_BUTTON_LABELS_SONY
		"nintendo":
			labels = CONTROLLER_BUTTON_LABELS_NINTENDO
	return labels.get(button_index, "Button " + str(button_index))


func refresh_label() -> void:
	if !action or !InputMap.has_action(action):
		return
	var left := "Unassigned"
	var right := "Unassigned"
	for event in InputMap.action_get_events(action):
		if event is InputEventJoypadButton:
			left = get_button_labels(event.button_index)
		elif event is InputEventJoypadMotion:
			left = get_axis_label(event.axis, event.axis_value)
		elif event is InputEventKey:
			var code = event.physical_keycode if event.physical_keycode != 0 else event.keycode
			right = OS.get_keycode_string(code)
	text_left = left
	text_right = right
	text = text_left + "   |   " + text_right

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
	var labels := CONTROLLER_AXIS_LABELS_XBOX
	match controller_identity:
		"sony":
			labels = CONTROLLER_AXIS_LABELS_SONY
		"nintendo":
			labels = CONTROLLER_AXIS_LABELS_NINTENDO
	if not labels.has(axis):
		return "unknown axis"
	if absf(value) < deadzone:
		return "input did not breach deadzone. Try again."
	var sign_key := 1 if value > 0 else -1
	return labels[axis].get(sign_key, "Unknown direction")

func identify_controller_type(device: int) -> void:
	var previous_controller_identity := controller_identity
	var controller_name := Input.get_joy_name(device).to_lower()
	var info := Input.get_joy_info(device)
	var vendor := int(info.get("vendor_id", 0))
	print("name: ", controller_name, " | vendor: ", vendor, " | info: ", info)

	if vendor == VENDOR_HEX_SONY \
	or "ps5" in controller_name or "ps4" in controller_name or "ps3" in controller_name \
	or "dualsense" in controller_name or "dualshock" in controller_name:
		controller_identity = "sony"
	elif vendor == VENDOR_HEX_NINTENDO \
	or "switch" in controller_name or "nintendo" in controller_name \
	or "pro controller" in controller_name:
		controller_identity = "nintendo"
	elif vendor == VENDOR_HEX_MICROSOFT \
	or "xbox" in controller_name or "xinput" in controller_name:
		controller_identity = "xbox"
	else:
		controller_identity = "generic"
	
	if controller_identity != previous_controller_identity:
		InputConfigHandler.controller_type_changed.emit()
	print(controller_identity)

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
	
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		identify_controller_type(event.device)
	

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
