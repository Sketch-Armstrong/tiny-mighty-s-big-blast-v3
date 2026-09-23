extends Node2D

#var typed_dict_reference_array: Array[int] = [0, 1, 2, 3, 4]
#var name_entry: String = ""
#var typed_dict_test: Dictionary[int, String] = {
	#typed_dict_reference_array[0] : name_entry
#}

@onready var Score_End_Label1 = $HighScoresPanel/Control/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
@onready var Score_End_Label2 = $HighScoresPanel/Control/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel2
@onready var Score_End_Label3 = $HighScoresPanel/Control/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel3
@onready var Score_End_Label4 = $HighScoresPanel/Control/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel4
@onready var Score_End_Label5 = $HighScoresPanel/Control/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel5

@onready var Score_Title_Label1 = $HighScoresTitleScreen/ScoresLabels/MarginContainer/VBoxContainer/RichTextLabel
@onready var Score_Title_Label2 = $HighScoresTitleScreen/ScoresLabels/MarginContainer/VBoxContainer/RichTextLabel2
@onready var Score_Title_Label3 = $HighScoresTitleScreen/ScoresLabels/MarginContainer/VBoxContainer/RichTextLabel3
@onready var Score_Title_Label4 = $HighScoresTitleScreen/ScoresLabels/MarginContainer/VBoxContainer/RichTextLabel4
@onready var Score_Title_Label5 = $HighScoresTitleScreen/ScoresLabels/MarginContainer/VBoxContainer/RichTextLabel5

@onready var Score_End_Initials1 = $HighScoresPanel/Control/PanelContainer2/MarginContainer/VBoxContainer/RichTextLabel
@onready var Score_End_Initials2 = $HighScoresPanel/Control/PanelContainer2/MarginContainer/VBoxContainer/RichTextLabel2
@onready var Score_End_Initials3 = $HighScoresPanel/Control/PanelContainer2/MarginContainer/VBoxContainer/RichTextLabel3
@onready var Score_End_Initials4 = $HighScoresPanel/Control/PanelContainer2/MarginContainer/VBoxContainer/RichTextLabel4
@onready var Score_End_Initials5 = $HighScoresPanel/Control/PanelContainer2/MarginContainer/VBoxContainer/RichTextLabel5

@onready var Score_Title_Iniitals1 = $HighScoresTitleScreen/InitialsLabels/MarginContainer/VBoxContainer/RichTextLabel
@onready var Score_Title_Iniitals2 = $HighScoresTitleScreen/InitialsLabels/MarginContainer/VBoxContainer/RichTextLabel2
@onready var Score_Title_Iniitals3 = $HighScoresTitleScreen/InitialsLabels/MarginContainer/VBoxContainer/RichTextLabel3
@onready var Score_Title_Iniitals4 = $HighScoresTitleScreen/InitialsLabels/MarginContainer/VBoxContainer/RichTextLabel4
@onready var Score_Title_Iniitals5 = $HighScoresTitleScreen/InitialsLabels/MarginContainer/VBoxContainer/RichTextLabel5

@onready var scores_title_screen = $HighScoresTitleScreen











@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	#_equalize_labels()
	pass

func _ready() -> void:
	pass

func save_game_now():
	GlobalHighscoreHandler.save_game()

func load_game_now():
	pass

func _on_save_button_pressed() -> void:
	save_game_now()


func _on_load_button_pressed() -> void:
	pass # Replace with function body.


func _on_clear_button_pressed() -> void:
	$"../ScoreBackButton".grab_focus()
	GlobalHighscoreHandler.clear_highscores()
	print("Clearing...")
	#await get_tree().create_timer(2.0).timeout
	
		## you need to add a waiting animation for this. Might want to add failsafe buffer
		## animations to the other save/load areas, too
		##
	
	#_equalize_labels()
	print("Cleared! :)")

func hide_end_highscores_panel() -> void:
	$HighScoresPanel.hide()
	$Sprite2D2.hide()

func show_end_highscores_panel() -> void:
	$HighScoresPanel.show()
	$Sprite2D2.show()

func show_title_scores_panels() -> void:
	#_equalize_labels()
	await get_tree().process_frame
	scores_title_screen.show()
	

func hide_title_scores_panels() -> void:
	scores_title_screen.hide()

func _equalize_labels() -> void:
	Score_Title_Label1.text = Score_End_Label1.text
	Score_Title_Label2.text = Score_End_Label2.text
	Score_Title_Label3.text = Score_End_Label3.text
	Score_Title_Label4.text = Score_End_Label4.text
	Score_Title_Label5.text = Score_End_Label5.text
	
	Score_Title_Iniitals1.text = Score_End_Initials1.text
	Score_Title_Iniitals2.text = Score_End_Initials2.text
	Score_Title_Iniitals3.text = Score_End_Initials3.text
	Score_Title_Iniitals4.text = Score_End_Initials4.text
	Score_Title_Iniitals5.text = Score_End_Initials5.text
