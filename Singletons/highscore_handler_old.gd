extends Node2D

var score_path = "user://score.save"
@export var minimum_highscore := 1000
@onready var highscore := 0
	#changing this ^ does succesfully save and load
@onready var reset_score := 0

@export var highscores_array: Array[int] = [5000, 4000, 3000, 2000, 1000]
		## this needs to be loaded and overwritten each _ready()


func _ready() -> void:
	pass
	load_score()
	#print("highscores array test was ", highscores_array[0])
	#_on_main_game_over()

func _process(delta: float) -> void:
	#$Control/HighScoreLabel1.text = str(highscore)
	pass

func _on_main_game_over() -> void:
	if GlobalVariables.results_snapshot <= minimum_highscore:
		print("minimum_highscore > score valid")
		return
	
	if GlobalVariables.results_snapshot > highscores_array[0]:
		print("score > 5000 valid")
		save_score(0)
		return
	
	if GlobalVariables.results_snapshot > highscores_array[1]:
		print("5000 > score > 4000 valid")
		save_score(1)
		return
	
	if GlobalVariables.results_snapshot > highscores_array[2]:
		print("4000 > score > 3000 valid")
		save_score(2)
		return
	
	if GlobalVariables.results_snapshot > highscores_array[3]:
		print("3000 > score > 2000 valid")
		save_score(3)
		return
		
	if GlobalVariables.results_snapshot > highscores_array[4]:
		save_score(4)
		print("2000 > score > 1000 valid")
		return

func save_score(array_number: int):
	var array_position = array_number
	print("array position var passed was ",array_position)
	
		## here I need to take the array position and overwrite that number in the array
		## also every _ready() I need to load the highscores array file and overwrite the 
		## highscores in this script
	
	#var file = FileAccess.open(score_path, FileAccess.WRITE)
	#file.store_var(GlobalVariables.results_snapshot)
	return

func load_score():
	if FileAccess.file_exists(score_path):
		print("file found")
		var file = FileAccess.open(score_path, FileAccess.READ)
		highscore = file.get_var()
		print(highscore)
	else:
		print("file not found")
		highscore = 0
	return
