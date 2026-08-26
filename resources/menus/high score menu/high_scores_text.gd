extends Node2D


@onready var Label1 = $Control/HighScoresTitleScreen/ScoresLabels/MarginContainer/VBoxContainer/RichTextLabel
@onready var Label2 = $Control/HighScoresTitleScreen/ScoresLabels/MarginContainer/VBoxContainer/RichTextLabel2
@onready var Label3 = $Control/HighScoresTitleScreen/ScoresLabels/MarginContainer/VBoxContainer/RichTextLabel3
@onready var Label4 = $Control/HighScoresTitleScreen/ScoresLabels/MarginContainer/VBoxContainer/RichTextLabel4
@onready var Label5 = $Control/HighScoresTitleScreen/ScoresLabels/MarginContainer/VBoxContainer/RichTextLabel5

@onready var Name1 = $Control/HighScoresTitleScreen/InitialsLabels/MarginContainer/VBoxContainer/RichTextLabel
@onready var Name2 = $Control/HighScoresTitleScreen/InitialsLabels/MarginContainer/VBoxContainer/RichTextLabel2
@onready var Name3 = $Control/HighScoresTitleScreen/InitialsLabels/MarginContainer/VBoxContainer/RichTextLabel3
@onready var Name4 = $Control/HighScoresTitleScreen/InitialsLabels/MarginContainer/VBoxContainer/RichTextLabel4
@onready var Name5 = $Control/HighScoresTitleScreen/InitialsLabels/MarginContainer/VBoxContainer/RichTextLabel5


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
