extends Node2D

#var tiny_position = [false, false, false, false, false]


@onready var miss := 0
@onready var Player := $Player
@onready var Hazards := $Hazards
@onready var score_label := $Score
@onready var score_tracker := 0
@onready var score := GlobalVariables.score_global
@onready var four_times_bonus_counter := 0
@export var four_times_bonus_score := 200
@onready var coin_bonus := 0
@onready var Bomb3 := $Miss/BombSprite3
@onready var Bomb2 := $Miss/BombSprite2
@onready var Bomb1 := $Miss/BombSprite
@onready var game_over_screen := $CanvasLayer/GameOver

@onready var round_timer_path = "RoundMeterMain/RoundTimer"
@onready var round_timer = get_node(round_timer_path) 
@onready var player_animation_player = Player.player_animation_player
@onready var tiny_collision_pos = Player.tiny_collision_pos

@onready var can_collide_master := true

@onready var main_style_value = 0

@onready var stop_oneup_spam := false
@onready var lives := 3

@onready var multiple_of_500_previous := 0

@onready var shimmered_bool_0_to_1000 := true
@onready var shimmered_bool_1000_to_2000 := true
@onready var shimmered_bool_2000_to_3000 := true
@onready var shimmered_bool_3000_to_4000 := true
@onready var shimmered_bool_4000_to_5000 := true
@onready var shimmered_bool_5000_plus := false

@onready var shimmer_timer_1 = $Miss/ShimmerTimers/ShimmerTimer1
@onready var shimmer_timer_2 = $Miss/ShimmerTimers/ShimmerTimer2
@onready var shimmer_timer_3 = $Miss/ShimmerTimers/ShimmerTimer3
@onready var shimmer_timer_4 = $Miss/ShimmerTimers/ShimmerTimer4
@onready var shimmer_timer_5 = $Miss/ShimmerTimers/ShimmerTimer5


@onready var player_still_blasting := false
signal player_truly_done_with_game

signal round_timer_stop
signal round_timer_start
signal style_on
signal style_off
signal game_start

signal game_over
## extranneous signals, that I didn't need to use




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#change_bombs_to_gems()
	$MusicTester.play()
	#GlobalVariables.hazard_count = 0
	#GlobalHighscoreHandler.global_highscore_snapper = GlobalVariables.results_snapshot
	GlobalVariables.room_number_global = 1
	GlobalVariables.round_count_global = 1
	GlobalVariables.level_count_global = 1
	GlobalVariables.four_round_complete_bonus_global = four_times_bonus_score
	GlobalVariables.a_plus_tripwire = true
	$CanvasLayer/PauseMenu.visible = false
	randomize()
	get_tree().paused = false
	$Control/Control/ColorRect/AnimationPlayer.play("main_scene_color_rect")
	
	await $Control/Control/ColorRect/AnimationPlayer.animation_finished
	game_start.emit()
	$Control.hide()
	game_over_screen.hide()
	_round_timer_start()
	_on_main_game_start()
	_start_all_shimmer_timers()

func _round_timer_start() -> void:
	#await get_tree().create_timer(0.0).timeout
		#tweak to time to animations later
	round_timer_start.emit()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		##change me later to be "Quit" button 
		get_tree().quit()
	score_label.text = str(score)
	
	GlobalVariables.lives_global = lives
	
	if GlobalVariables.music_player_boolean == true:
		$MusicTester.volume_db = -20.0
	if GlobalVariables.music_player_boolean == false:
		$MusicTester.volume_db = -10.0

	
	if GlobalVariables.global_style_meter_value >= 80:
		if $JackpotTester.playing:
			pass
		else:
			$JackpotTester.play()
	
	if GlobalVariables.global_style_meter_value < 80:
		if $JackpotTester.playing:
			$JackpotTester.stop()
	
	if Input.is_action_just_pressed("take_damage"):
			## killbind for testing
		_on_hazard_a_hazard_a_miss()
		#pass
	
	if Input.is_action_just_pressed("debugging_score_up"):
		score += 500
	
	#score_label.text = str("123456789")
	"""
	CHANGE THE MISS VALUE HERE TO TEST
	"""

	## print(int(player_miss_timer.time_left))
	main_style_value = $StyleMeterRoot.style_value
	
	#print("global results snapshot was ", GlobalVariables.results_snapshot)
	check_lives_count()
	show_or_hide_lives_label()
	check_score_and_shimmer()
	pass

func check_score_and_shimmer():
	if score >= 0:
		pass
		if score >= 5000 and shimmered_bool_5000_plus == false and GlobalVariables.a_plus_tripwire == true:
			_stop_all_shimmer_timers()
			_set_all_shimmer_bools_true()
			change_bombs_to_gems()
			return
			## play the change shape animation
		
		elif score >= 4000  and score < 5000 and shimmered_bool_4000_to_5000 == false and GlobalVariables.a_plus_tripwire == true:
			Bomb3.bomb_shimmer()
			shimmered_bool_4000_to_5000 = true
			return
		
		elif score >= 3000 and score < 4000 and shimmered_bool_3000_to_4000 == false and GlobalVariables.a_plus_tripwire == true:
			Bomb3.bomb_shimmer()
			shimmered_bool_3000_to_4000 = true
			return
		
		elif score >= 2000 and score < 3000 and shimmered_bool_2000_to_3000 == false and GlobalVariables.a_plus_tripwire == true:
			Bomb3.bomb_shimmer()
			shimmered_bool_2000_to_3000 = true
			return
		
		elif score >= 1000 and score < 2000 and shimmered_bool_1000_to_2000 == false and GlobalVariables.a_plus_tripwire == true:
			Bomb3.bomb_shimmer()
			shimmered_bool_1000_to_2000 = true
			return

		elif score >= 0 and score < 1000 and shimmered_bool_0_to_1000 == false and GlobalVariables.a_plus_tripwire == true:
			Bomb3.bomb_shimmer()
			shimmered_bool_0_to_1000 = true
			return


func _on_shimmer_timer_1_timeout() -> void:
	shimmered_bool_0_to_1000 = false


func _on_shimmer_timer_2_timeout() -> void:
	shimmered_bool_1000_to_2000 = false


func _on_shimmer_timer_3_timeout() -> void:
	shimmered_bool_3000_to_4000 = false


func _on_shimmer_timer_4_timeout() -> void:
	shimmered_bool_4000_to_5000 = false


func _on_shimmer_timer_5_timeout() -> void:
	pass

func _stop_all_shimmer_timers() -> void:
	shimmer_timer_1.stop()
	shimmer_timer_2.stop()
	shimmer_timer_3.stop()
	shimmer_timer_4.stop()

func _start_all_shimmer_timers() -> void:
	shimmer_timer_1.start()
	shimmer_timer_2.start()
	shimmer_timer_3.start()
	shimmer_timer_4.start()

func _set_all_shimmer_bools_true() -> void:
	shimmered_bool_0_to_1000 = true
	shimmered_bool_2000_to_3000 = true
	shimmered_bool_2000_to_3000 = true
	shimmered_bool_3000_to_4000 = true
	shimmered_bool_5000_plus = true

func _set_all_shimmer_bools_false() -> void:
	shimmered_bool_0_to_1000 = false
	shimmered_bool_2000_to_3000 = false
	shimmered_bool_2000_to_3000 = false
	shimmered_bool_3000_to_4000 = false
	shimmered_bool_5000_plus = false


func change_bombs_to_gems() -> void:
	Bomb3.change_to_gem()
	await get_tree().create_timer(0.2).timeout
	Bomb2.change_to_gem()
	await get_tree().create_timer(0.2).timeout
	Bomb1.change_to_gem()
	

func show_or_hide_lives_label():
	if lives > 3:
		$Miss/LivesLabel.show()
	else:
		$Miss/LivesLabel.hide()


func check_lives_count():
	pass
	$Miss/LivesLabel.text = str(lives)
	
	var multiple_of_500_current: int = maxi(snappedi(score - 250, 500), 0)
	#print("snapping of score result: ", multiple_of_500_current)
	#print("lives count,", lives)
	
	if multiple_of_500_current < multiple_of_500_previous:
		multiple_of_500_previous = multiple_of_500_current
		return
	
	if multiple_of_500_current == multiple_of_500_previous:
		return
	
	var extra_lives := roundi((multiple_of_500_current - multiple_of_500_previous) / 500.0)
	multiple_of_500_previous = multiple_of_500_current
	
	for i in extra_lives:
		lives += 1
		$"Miss/1upBonusText".play_1up_animation()
		if lives == 3:
			$Miss/BombSprite2.bomb_reset()
			$Miss/BombSprite3.bomb_reset()
		elif lives == 2:
			$Miss/BombSprite2.bomb_reset()



func update_bonus_label():
		##calling this is in the player.gd script
	#print("update_bonus_label line 96 proc'd")
	var timer_bonus = round(round_timer.time_left)
	GlobalVariables.timer_bonus_global = (10 - timer_bonus)
	GlobalVariables.coin_bonus_global = (coin_bonus + 1)

	#print("global var timer bonus was ", GlobalVariables.timer_bonus_global)
	#print("global var coin bonus was ", GlobalVariables.coin_bonus_global)
	$BonusText.update_text()

func increment_score() -> void:
	var timer_bonus = round(round_timer.time_left)
	GlobalStatTracking.time_bonus_counts[timer_bonus] += 1
	print(str(GlobalStatTracking.time_bonus_counts))
	#print(10 - timer_bonus)
	four_times_bonus_counter += 1
	if four_times_bonus_counter == 4:
		four_times_bonus_counter = 0
		score += four_times_bonus_score
		$RoundBonusText.show_round_bonus()
		GlobalVariables.end_four_round_complete_bonus_total += four_times_bonus_score
		GlobalStatTracking.total_garbage_bonuses += 1
			#4 times bonus needs to be rewarding enough to feel good, but not 
			#OP to the point where the best strat is just spamming right
	score += (10 - timer_bonus) * (coin_bonus + 1)
	GlobalVariables.end_coin_and_timer_bonuses_total += (10 - timer_bonus) * (coin_bonus + 1)
	GlobalVariables.end_timer_bonus_total += (10 - timer_bonus)
	#GlobalVariables.end_coin_bonus_total += (coin_bonus + 1)
	coin_bonus = 0
	GlobalVariables.coin_counter_tracker_global = 1
	_round_timer_start()
	

func style_bonus(bonus_value: int) -> void:
	score += bonus_value
		#make this a simple decaying +5 for any move, so it's *some* but not *a lot*

func style_meter_value() -> void:
	pass
		#this is a placeholder function in case I need it for calculating the overall style meter's
		#value, for increment_score()


func taunt_bonus() -> void: 
	score += 10

func near_miss() -> void:
	score += 5

#func _on_hazards_miss() -> void:
	#miss += 1
	## print("main miss detected")


func _on_player_nova_blast() -> void:
	round_timer_stop.emit()
	await get_tree().create_timer(0.1).timeout
	can_collide_master = true

func _on_hazard_a_hazard_a_miss() -> void:
	print("miss death count was: ", miss)
	GlobalVariables.results_snapshot = score
	round_timer_stop.emit()
	
	_miss()
	## print("returned from _miss() function to A miss")
	can_collide_master = false
	Player.miss_function()
	await get_tree().create_timer(1.8).timeout
	can_collide_master = true
	if lives > 0:
		_round_timer_start()


func _on_hazard_b_hazard_b_miss() -> void:
	## this one is vestigial. Left in to not break overlooked scripting
	lives -= 1
	_miss()
	Player.miss_function()


func _miss() -> void:
	#print("Oh no! Player lost ", coin_bonus, " coins!")
	lives -= 1
	if score < 5000:
		GlobalVariables.a_plus_tripwire = false
	GlobalVariables.music_player_boolean = true
	GlobalVariables.results_snapshot = score
	GlobalVariables.coin_snapshot = coin_bonus + 1
	GlobalVariables.coin_counter_tracker_global = 1
	##$MissSound.play()
	#print("global coin snap on line 179 was", GlobalVariables.coin_snapshot)
	coin_bonus = 0
	#print("global coin snap on line 181 was", GlobalVariables.coin_snapshot)
	if lives == 2:
		Bomb3.bomb_blow()
	if lives == 1:
		Bomb2.bomb_blow()
	if lives == 0:
		Bomb1.bomb_blow()
		#game_over_screen.show()
		_on_main_game_game_over()
		$MusicTester.stop()
	return

func _on_hazard_coin_score() -> void:
	score += 1
	coin_bonus += 1
	Player.show_coin_count()
	## print("coin +5 main scene proc'd")

func can_collide_master_on() -> void: 
	can_collide_master = true

func can_collide_master_off() -> void:
	can_collide_master = false

func can_style_master_on() -> void: 
	style_on.emit()

func can_style_master_off() -> void:
	style_off.emit()


func _on_game_over_quit() -> void:
	get_tree().change_scene_to_file("res://resources/menus/main menu/main_menu.tscn")


func _on_game_over_retry() -> void:
	$MusicTester.play()
	GlobalVariables.a_plus_tripwire = true
	game_over_screen.hide()
	lives = 3
	four_times_bonus_counter = 0
	score = 0
	round_timer_start.emit()
	Bomb3.bomb_reset()
	Bomb2.bomb_reset()
	Bomb1.bomb_reset()
	Player.reset_tiny()
	$TimeLeft/GameTimer.start()
	_start_all_shimmer_timers()
	_set_all_shimmer_bools_false()
	Hazards.show()
	$GameOverMainNodes/GameOverAnimationPlayer.play("RESET")

func _on_main_game_start() -> void:

	GlobalVariables.a_plus_tripwire = true
	game_over_screen.hide()
	lives = 3
	four_times_bonus_counter = 0
	score = 0
	round_timer_start.emit()
	Bomb3.bomb_reset()
	Bomb2.bomb_reset()
	Bomb1.bomb_reset()
	#Player.reset_tiny()

	$TimeLeft/GameTimer.start()

func _on_round_meter_main_round_timer_timeout() -> void:
	round_timer_stop.emit()
	_on_hazard_a_hazard_a_miss()

func _on_main_game_game_over():
	#GlobalVariables.results_snapshot = score
	$TimeLeft/GameTimer.stop()
	$MusicTester.stop()
	if player_still_blasting == true:
		_stop_all_shimmer_timers()
		_set_all_shimmer_bools_true()
		await player_truly_done_with_game
		Player.game_over_stop_player()
		#print("game over time extension working")
		#await get_tree().create_timer(2).timeout
		#print("2 second time extension")
		GlobalVariables.score_global = score
		GlobalVariables.results_snapshot = GlobalVariables.score_global
		pass
		print("local score before lives was: ", str(score))
		print("global score before lives was: ", str(GlobalVariables.score_global))
		$GameOverMainNodes/GameOverAnimationPlayer.play("Time_Over")
		await $GameOverMainNodes/GameOverAnimationPlayer.animation_finished
		GlobalVariables.score_global = score
		GlobalVariables.results_snapshot = GlobalVariables.score_global
		

		pass
		game_over.emit()
		Player.game_over_stop_player()
	
	else:
		Player.game_over_stop_player()
		_stop_all_shimmer_timers()
		_set_all_shimmer_bools_true()
		print("2 second time extension")
		
				## and here
		
		#await get_tree().create_timer(2).timeout
		GlobalVariables.score_global = score
		GlobalVariables.results_snapshot = GlobalVariables.score_global
		pass
		print("local score before lives was: ", str(score))
		print("global score before lives was: ", str(GlobalVariables.score_global))
		$GameOverMainNodes/GameOverAnimationPlayer.play("Time_Over")
		await $GameOverMainNodes/GameOverAnimationPlayer.animation_finished
		GlobalVariables.score_global = score
		GlobalVariables.results_snapshot = GlobalVariables.score_global
		

		pass
		game_over.emit()
		Player.game_over_stop_player()
	
	#game_over_screen.show()


func add_lives_to_score() -> void:
	pass
	$GameOverMainNodes/Node2D2/Node2D/LivesBonusTextControl/LivesBonusTextLabel.text = str(GlobalVariables.lives_global)
	var lives_bonus = GlobalVariables.lives_global
	score += lives_bonus * 50
	


func _on_pause_menu_main_theme_pause() -> void:
	$MusicTester.stream_paused = true




func _on_pause_menu_main_theme_resume() -> void:
	$MusicTester.stream_paused = false


func _on_player_player_nova_blast() -> void:
	player_still_blasting = true
	print("player still blasting")

func _on_player_player_nova_blast_finished() -> void:
	player_still_blasting = false
	player_truly_done_with_game.emit()
	print("player done blasting")
