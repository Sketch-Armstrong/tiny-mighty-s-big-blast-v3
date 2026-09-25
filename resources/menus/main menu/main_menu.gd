extends Node2D

signal main_menu

@onready var menu_player := $MenusAnimationPlayer
@onready var tiny_player := $TinyAnimationPlayer
@onready var back_button := $CanvasLayer2/Node2D2/BackButton
@onready var highscore_handler := $CanvasLayer2/HighScores/HighScoreHandler
@onready var highscore_control := $CanvasLayer2/HighScores

signal options_focus

func _ready() -> void:
	_make_control_click_through($CanvasLayer2/CRT)
	#highscore_control.hide()
	#GlobalFocusBooleans.main_menu_focus = true
	$CanvasLayer2/Node2D/ButtonManager/Start.grab_focus()
	highscore_handler.hide_end_highscores_panel()
	highscore_handler.show_title_scores_panels()
	main_menu.emit()
	tiny_player.play("tiny_enter")
	await tiny_player.animation_finished
	tiny_player.play("tiny_idle")
	pass
	#$ColorRect/AnimationPlayer.play("fade_in")

func _make_control_click_through(node: Node) -> void:
	for child in node.get_children():
		if child is Control:
			child.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_make_control_click_through(child)

func _on_start_pressed():
	$Control.show()
	$CanvasLayer2/Node2D/ButtonManager.hide()
	$CanvasLayer2/HowToPlay/HowToPlayButton.hide()
	$FocusArrow.hide()
	$Control/ColorRect/AnimationPlayer.play("fade_in")
	#$Node2D/AnimationPlayer.play("test")
	await $Control/ColorRect/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://resources/Intro Comic/Scenes/intro_comic.tscn")
	pass

func _on_options_pressed() -> void:
	$FocusArrow.hide()
	$CanvasLayer2/Node2D/ButtonManager/Options.release_focus()
	menu_player.play("main_buttons_exit")
	await menu_player.animation_finished
	menu_player.play("options_menu_enter")
	await menu_player.animation_finished
	options_focus.emit()
	#$CanvasLayer2/Node2D2/BackButton.grab_focus()

func _on_back_button_pressed() -> void:
	$CanvasLayer2/Node2D2/BackButton.release_focus()
	menu_player.play("options_menu_exit")
	await menu_player.animation_finished
	menu_player.play("main_buttons_enter")
	$FocusArrow.show()
	await menu_player.animation_finished
	$CanvasLayer2/Node2D/ButtonManager/Options.grab_focus()

func _on_quit_pressed() -> void:
	tiny_player.play("frown")
	await tiny_player.animation_finished
	get_tree().quit()


func _on_scores_pressed() -> void:
	$FocusArrow.hide()
	$CanvasLayer2/Node2D/ButtonManager/Scores.release_focus()
	highscore_handler._equalize_labels()
	menu_player.play("main_buttons_exit")
	await menu_player.animation_finished
	highscore_control.show()
	menu_player.play("scores_enter")
	await menu_player.animation_finished
	$CanvasLayer2/HighScores/ScoreBackButton.grab_focus()

func _on_score_back_button_pressed() -> void:
	$CanvasLayer2/HighScores/ScoreBackButton.release_focus()
	menu_player.play("scores_exit")
	await menu_player.animation_finished
	highscore_control.hide()
	menu_player.play("main_buttons_enter")
	$FocusArrow.show()
	await menu_player.animation_finished
	$CanvasLayer2/Node2D/ButtonManager/Scores.grab_focus()

func _on_legal_pressed() -> void:
	$FocusArrow.hide()
	$CanvasLayer2/Node2D/ButtonManager/Legal.release_focus()
	menu_player.play("main_buttons_exit")
	await menu_player.animation_finished
	menu_player.play("legal_enter")
	await menu_player.animation_finished
	$CanvasLayer2/Legal/LegalBackButton.grab_focus()

func _on_legal_back_button_pressed() -> void:
	$CanvasLayer2/Legal/LegalBackButton.release_focus()
	menu_player.play("legal_exit")
	await menu_player.animation_finished
	menu_player.play("main_buttons_enter")
	$FocusArrow.show()
	await menu_player.animation_finished
	$CanvasLayer2/Node2D/ButtonManager/Legal.grab_focus()



	


func _on_how_to_play_button_pressed() -> void:
	pass # Replace with function body.
	$FocusArrow.hide()
	$CanvasLayer2/HowToPlay/HowToPlayButton.release_focus()
	menu_player.play("main_buttons_exit")
	await menu_player.animation_finished
	menu_player.play("how_to_play_enter")
	await menu_player.animation_finished
	$CanvasLayer2/HowToPlay/HowToPlay/HowToPlayBackButton.grab_focus()


func _on_how_to_play_back_button_pressed() -> void:
	pass # Replace with function body.
	$CanvasLayer2/HowToPlay/HowToPlayButton.release_focus()
	menu_player.play("how_to_play_exit")
	await menu_player.animation_finished
	menu_player.play("main_buttons_enter")
	$FocusArrow.show()
	await menu_player.animation_finished
	$CanvasLayer2/HowToPlay/HowToPlayButton.grab_focus()
