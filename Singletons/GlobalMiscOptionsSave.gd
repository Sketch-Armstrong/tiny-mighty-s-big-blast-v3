extends Node

## global miscellanneous options I didn't want to muddy up other scripts with

var global_fullscreen_bool := false
var global_crt_enabled := true
var reduce_screen_shake := false

var options_config = ConfigFile.new()

const OPTIONS_SETTINGS_FILE_PATH:String = "user://misc_options.cfg"


func _ready() -> void:
	load_options()
	apply_window_mode()

func load_options() -> void:
	var err := options_config.load(OPTIONS_SETTINGS_FILE_PATH)
	if err != OK:
		save_options()
		return
	global_fullscreen_bool = options_config.get_value("window_options", "fullscreen", false)
	global_crt_enabled = options_config.get_value("display_options", "crt_enabled", true)
	reduce_screen_shake = options_config.get_value("accessibility_options", "reduce_screen_shake", false)

func save_options() -> void:
	options_config.set_value("window_options", "fullscreen", global_fullscreen_bool)
	options_config.set_value("display_options", "crt_enabled", global_crt_enabled)
	options_config.set_value("accessibility_options", "reduce_screen_shake", reduce_screen_shake)
	options_config.save(OPTIONS_SETTINGS_FILE_PATH)

func determine_window_mode(value: bool) -> void:
	global_fullscreen_bool = value
	apply_window_mode()
	save_options()

func apply_window_mode() -> void:
	if global_fullscreen_bool == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func set_crt_option(value: bool) -> void:
	global_crt_enabled = value
	apply_crt()
	save_options()

func set_reduce_screen_shake(value: bool) -> void:
	reduce_screen_shake = value
	save_options()


func apply_crt() -> void:
	var crt := get_tree().get_first_node_in_group("crt")
	if crt:
		crt.set_crt_enabled(global_crt_enabled)
