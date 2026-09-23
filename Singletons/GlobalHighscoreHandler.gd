extends Node

		## This is the global highscore tracker   

var default_highscores_array: Array[int] = [5000, 4000, 3000, 2000, 1000]
var default_highscores_names_array: Array[String] = ["SMW", "P.R", "MVS", "ECM", "BIG"]
			## DO NOT CHANGE THESE TWO! They aren't constants to avoid conflicting with 
			## read-only errors.



var global_pending_score: int = 0   # captured once, not re-read later

var global_highscores_array: Array[int] = [5000, 4000, 3000, 2000, 1000]
var global_highscores_names_array: Array[String] = ["SMW", "P.R", "MVS", "ECM", "BIG"]
var global_highscore_is_perfect: bool = false
var global_highscores_array_position: int = 0
var global_minimum_highscore := 1000
var initials_input_1: String = "replace"
var initials_input_2: String = "this"
var initials_input_3: String = "later"

var global_initials_combined: String = ""
var global_initials_can_input: bool = false

var save_path:String = "user://save_game.res"

signal save_complete

func test_global_function() -> void:
	print("global function works")
	check_highscore()

func _ready() -> void:
	load_game()
	print("the global highscores array was: ", str(global_highscores_array))

# GlobalHighscoreHandler.gd


func check_highscore() -> void:
	if GlobalVariables.results_snapshot <= global_minimum_highscore:
		return

	# Guard against re-entrancy: don't let a second score event
	# clobber a submission that's still waiting on initials.
	if global_initials_can_input:
		return

	global_pending_score = GlobalVariables.results_snapshot
	global_initials_can_input = true

	if global_pending_score > 5000 and GlobalVariables.a_plus_tripwire:
		global_highscore_is_perfect = true
	elif global_pending_score > 5000:
		global_highscore_is_perfect = false

	for i in global_highscores_array.size():
		if global_pending_score > global_highscores_array[i]:
			global_highscores_array_position = i
			return   # position is now staged; DON'T write yet

	# didn't beat anything — shouldn't happen given the minimum check above
	global_initials_can_input = false

func update_highscore(array_position: int) -> void:
	# Insert with shift: push lower entries down, drop the last one.
	global_highscores_array.insert(array_position, global_pending_score)
	global_highscores_array.remove_at(global_highscores_array.size() - 1)

	global_highscores_names_array.insert(array_position, global_initials_combined)
	global_highscores_names_array.remove_at(global_highscores_names_array.size() - 1)

func initials_input_complete() -> void:
	print("initials_input_complete() was called")
	check_highscore()

func save_game():
	print("SAVING")
	var new_save_game:SaveGame = SaveGame.new()
	new_save_game.high_score_array_save = global_highscores_array
	new_save_game.high_score_name_array_save = global_highscores_names_array
	new_save_game.high_score_perfect_boolean = global_highscore_is_perfect
	var error = ResourceSaver.save(new_save_game,save_path)
	if error == OK:
		print("Saved :)")
		save_complete.emit()
	else:
		print("No save :(")

func load_game():
	print("LOADING")
	if ResourceLoader.exists(save_path):
		var loaded_data = ResourceLoader.load(save_path).duplicate(true) as SaveGame
		if loaded_data:
			global_highscores_array = loaded_data.high_score_array_save
			global_highscores_names_array = loaded_data.high_score_name_array_save
			global_highscore_is_perfect = loaded_data.high_score_perfect_boolean
			print("Save loaded :)")
		else:
			print("no data loaded")
	else:
		print("no save path found")
		print("creating save data")
		save_game()

func clear_highscores():
	print("CLEARING")
	global_highscores_array = [5000, 4000, 3000, 2000, 1000]
	global_highscores_names_array = ["SMW", "P.R", "MVS", "ECM", "BIG"]
	global_highscore_is_perfect = false
	save_game()
	print("Cleared!")
