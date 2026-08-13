extends Node

		## This is the global highscore tracker   

var default_highscores_array: Array[int] = [5000, 4000, 3000, 2000, 1000]
var default_highscores_names_array: Array[String] = ["SMW", "P.R", "MVS", "ECM", "BIG"]
			## DO NOT CHANGE THESE TWO! They aren't constants to avoid conflicting with 
			## read-only errors.


var global_highscores_array: Array[int] = [5000, 4000, 3000, 2000, 1000]
var global_highscores_names_array: Array[String] = ["SMW", "P.R", "MVS", "ECM", "BIG"]
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

func check_highscore() -> void:
	#print("check_highscore activated")
	
	if GlobalVariables.results_snapshot <= global_minimum_highscore:
		return
	
	GlobalHighscoreHandler.global_initials_can_input = true
	
	if GlobalVariables.results_snapshot > global_highscores_array[0]:
		global_highscores_array_position = 0
		update_highscore(global_highscores_array_position)
		return
	
	if GlobalVariables.results_snapshot > global_highscores_array[1]:
		global_highscores_array_position = 1
		update_highscore(global_highscores_array_position)
		return
	
	if GlobalVariables.results_snapshot > global_highscores_array[2]:
		global_highscores_array_position = 2
		update_highscore(global_highscores_array_position)
		return
	
	if GlobalVariables.results_snapshot > global_highscores_array[3]:
		global_highscores_array_position = 3
		update_highscore(global_highscores_array_position)
		return
	
	if GlobalVariables.results_snapshot > global_highscores_array[4]:
		global_highscores_array_position = 4
		update_highscore(global_highscores_array_position)
		return
	
	return

func update_highscore(array_position) -> void:
	global_highscores_array[array_position] = GlobalVariables.results_snapshot
	global_highscores_names_array[array_position] = GlobalHighscoreHandler.global_initials_combined
	return 

func initials_input_complete() -> void:
	print("initials_input_complete() was called")
	check_highscore()

func save_game():
	print("SAVING")
	var new_save_game:SaveGame = SaveGame.new()
	new_save_game.high_score_array_save = global_highscores_array
	new_save_game.high_score_name_array_save = global_highscores_names_array
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
	save_game()
	print("Cleared!")
	pass
