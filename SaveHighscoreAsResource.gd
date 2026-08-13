## in the example project, this handles saving and loading everything

class_name SaveHighscoreAsResource
extends Resource

const SAVE_GAME_BASE_PATH := "user://save"
	#extension was removed to show how you can save in text during dev/debug builds,
	#and binary in the full release

@export var version := 1
	#detect old player saves and update their data

@export var highscores: Resource = Highscores.new()
	#I guess this is to save the auxillary resources alongside this resource, in the demo

# the following three functions were said to be thin wrappers that keep the save API inside of
# the SaveHighscoreAsResource resource.
func write_savegame() -> void:
	ResourceSaver.save(self, get_save_path())

static func save_exists() -> bool: 
	return ResourceLoader.exists(get_save_path())

static func load_savegame() -> Resource:
	var save_path := get_save_path()
	return ResourceLoader.load(save_path, "", ResourceLoader.CACHE_MODE_IGNORE)

#save and load a text resource in debug, and binary resource in release
static func get_save_path() -> String:
	var extension := ".tres" if OS.is_debug_build() else ".res"
	return SAVE_GAME_BASE_PATH + extension
