extends Control

@warning_ignore("unused_signal")
signal save_highscores
@warning_ignore("unused_signal")
signal load_highscores

@export var highscore_adjust_test := 0



@onready var Label1 = $Control/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
@onready var Label2 = $Control/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel2
@onready var Label3 = $Control/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel3
@onready var Label4 = $Control/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel4
@onready var Label5 = $Control/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel5

@onready var Name1 = $Control/PanelContainer2/MarginContainer/VBoxContainer/RichTextLabel
@onready var Name2 = $Control/PanelContainer2/MarginContainer/VBoxContainer/RichTextLabel2
@onready var Name3 = $Control/PanelContainer2/MarginContainer/VBoxContainer/RichTextLabel3
@onready var Name4 = $Control/PanelContainer2/MarginContainer/VBoxContainer/RichTextLabel4
@onready var Name5 = $Control/PanelContainer2/MarginContainer/VBoxContainer/RichTextLabel5


				## THIS might be a good place for a dictionary, though


func _ready() -> void:
	pass
	

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	Label1.text = str(GlobalHighscoreHandler.global_highscores_array[0])
	Label2.text = str(GlobalHighscoreHandler.global_highscores_array[1])
	Label3.text = str(GlobalHighscoreHandler.global_highscores_array[2])
	Label4.text = str(GlobalHighscoreHandler.global_highscores_array[3])
	Label5.text = str(GlobalHighscoreHandler.global_highscores_array[4])
	
	Name1.text = str(GlobalHighscoreHandler.global_highscores_names_array[0])
	Name2.text = str(GlobalHighscoreHandler.global_highscores_names_array[1])
	Name3.text = str(GlobalHighscoreHandler.global_highscores_names_array[2])
	Name4.text = str(GlobalHighscoreHandler.global_highscores_names_array[3])
	Name5.text = str(GlobalHighscoreHandler.global_highscores_names_array[4])

func update_high_scores() -> void:
		## so right here I think I need to be pulling the array from the save file, and setting them
		## equal to the saved ints
	Label1.text = str(GlobalHighscoreHandler.global_highscores_array[0])
	Label2.text = str(GlobalHighscoreHandler.global_highscores_array[1])
	Label3.text = str(GlobalHighscoreHandler.global_highscores_array[2])
	Label4.text = str(GlobalHighscoreHandler.global_highscores_array[3])
	Label5.text = str(GlobalHighscoreHandler.global_highscores_array[4])
	
	Name1.text = str(GlobalHighscoreHandler.global_highscores_names_array[0])
	Name2.text = str(GlobalHighscoreHandler.global_highscores_names_array[1])
	Name3.text = str(GlobalHighscoreHandler.global_highscores_names_array[2])
	Name4.text = str(GlobalHighscoreHandler.global_highscores_names_array[3])
	Name5.text = str(GlobalHighscoreHandler.global_highscores_names_array[4])
	
	
	return


func _on_high_score_handler_game_over_score_check_baton_pass() -> void:
	GlobalHighscoreHandler.check_highscore()
	#print("game over and update scores signal recieved")
