extends Node

## global miscellanneous options I didn't want to muddy up other scripts with

var global_fullscreen_bool := false
var global_crt_enabled := true
var reduce_screen_shake := false
var bus_volumes := {"Master": 1.0, "Music": 1.0, "SFX": 1.0}

var options_config = ConfigFile.new()

const OPTIONS_SETTINGS_FILE_PATH:String = "user://misc_options.cfg"


func _ready() -> void:
	load_options()
	apply_window_mode()
	apply_bus_volumes()

func load_options() -> void:
	var err := options_config.load(OPTIONS_SETTINGS_FILE_PATH)
	if err != OK:
		save_options()
		return
	global_fullscreen_bool = options_config.get_value("window_options", "fullscreen", false)
	global_crt_enabled = options_config.get_value("display_options", "crt_enabled", true)
	reduce_screen_shake = options_config.get_value("accessibility_options", "reduce_screen_shake", false)
	for bus_name in bus_volumes:
		bus_volumes[bus_name] = options_config.get_value("audio_options", bus_name, 1.0)

func save_options() -> void:
	options_config.set_value("window_options", "fullscreen", global_fullscreen_bool)
	options_config.set_value("display_options", "crt_enabled", global_crt_enabled)
	options_config.set_value("accessibility_options", "reduce_screen_shake", reduce_screen_shake)
	for bus_name in bus_volumes:
		options_config.set_value("audio_options", bus_name, bus_volumes[bus_name])
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

func set_bus_volume(bus_name: String, linear_value: float) -> void:
	bus_volumes[bus_name] = linear_value
	save_options()

func apply_bus_volumes() -> void:
	for bus_name in bus_volumes:
		var audio_index := AudioServer.get_bus_index(bus_name)
		if audio_index != -1:
			AudioServer.set_bus_volume_db(audio_index, linear_to_db(bus_volumes[bus_name]))
