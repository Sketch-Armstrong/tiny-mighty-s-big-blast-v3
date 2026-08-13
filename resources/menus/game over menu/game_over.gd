extends Control

signal retry
signal quit
signal game_over_score_check
@onready var results_label := $ResultsLabel
@onready var g_over_player := $GameOverPlayer
@onready var rank_sprites := $RankingsSprites
@onready var highscore_handler := $HighScoreHandler

#var highscores = ResourceLoader.load("user://save") as Highscores

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#highscores.check_highscore()
	highscore_handler.show_end_highscores_panel()
	highscore_handler.hide_title_scores_panels()
	g_over_player.play("papers_slide")
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	#results_label.text = str(GlobalVariables.results_snapshot / 10)
	if GlobalVariables.can_retry == true:
		$RetryButton.disabled = false
	if GlobalVariables.can_retry == false:
		$RetryButton.disabled = true

	if GlobalVariables.can_quit == true:
		$QuitButton.disabled = false
	if GlobalVariables.can_quit == false:
		$QuitButton.disabled = true
	pass

func _on_retry_button_pressed() -> void:
	retry.emit()
	GlobalHighscoreHandler.global_initials_can_input = false
	GlobalVariables.end_coin_bonus_total = 0
	GlobalVariables.end_four_round_complete_bonus_total = 0
	GlobalVariables.end_timer_bonus_total = 0
	GlobalVariables.end_coin_and_timer_bonuses_total = 0
	# print("retry send_four_round_complete_bonus_total emitted")

func _on_quit_button_pressed() -> void:
	quit.emit()
	GlobalHighscoreHandler.global_initials_can_input = false
	GlobalVariables.end_coin_bonus_total = 0
	GlobalVariables.end_four_round_complete_bonus_total = 0
	GlobalVariables.end_timer_bonus_total = 0
	GlobalVariables.end_coin_and_timer_bonuses_total = 0
	# print("quit signal emitted")

func _on_main_game_over() -> void:
	game_over_score_check.emit()
	#print("global bonuses tracking was ",GlobalVariables.end_coin_bonus_total," ",
	#GlobalVariables.end_four_round_complete_bonus_total," ",GlobalVariables.end_timer_bonus_total)
	
	GlobalHighscoreHandler.check_highscore()
		## this is what causes the scores table to update and be checked
	
	@warning_ignore("integer_division")
	results_label.text = str(GlobalVariables.results_snapshot)
	if GlobalVariables.results_snapshot < 200:
		## E Rank
		rank_sprites.set_frame(0)
	if GlobalVariables.results_snapshot >= 200 and GlobalVariables.results_snapshot < 400:
		## D Rank
		rank_sprites.set_frame(1)
	if GlobalVariables.results_snapshot >= 400 and GlobalVariables.results_snapshot < 600:
		## C Rank
		rank_sprites.set_frame(2)
	if GlobalVariables.results_snapshot >= 600 and GlobalVariables.results_snapshot < 800:
		## B Rank
		rank_sprites.set_frame(3)
	if GlobalVariables.results_snapshot >= 800 and GlobalVariables.results_snapshot < 1000:
		## A Rank
		rank_sprites.set_frame(4)
	if GlobalVariables.results_snapshot >= 1000 and GlobalVariables.a_plus_tripwire == false:
		## A Rank
		rank_sprites.set_frame(4)
	if GlobalVariables.results_snapshot >= 1000 and GlobalVariables.a_plus_tripwire == true:
		## A PLUS Rank
		rank_sprites.set_frame(5)
	g_over_player.play("papers_slide")
	
	
