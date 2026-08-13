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




signal round_timer_stop
signal round_timer_start
signal style_on
signal style_off
#signal game_start

signal game_over
## extranneous signals, that I didn't need to use




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	$Control/ColorRect/AnimationPlayer.play("fade_out")
	await $Control/ColorRect/AnimationPlayer.animation_finished
	$Control.hide()
	game_over_screen.hide()
	_round_timer_start()
	_on_game_over_retry()

func _round_timer_start() -> void:
	#await get_tree().create_timer(0.0).timeout
		#tweak to time to animations later
	round_timer_start.emit()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		##change me later to be "Quit" button 
		get_tree().quit()
	score_label.text = str(score)
	
	if GlobalVariables.music_player_boolean == true:
		$MusicTester.volume_db = -20.0
	if GlobalVariables.music_player_boolean == false:
		$MusicTester.volume_db = -10.0

	
	if GlobalVariables.hazard_count > 15:
		if $JackpotTester.playing:
			pass
		else:
			$JackpotTester.play()
	
	if GlobalVariables.hazard_count < 15:
		if $JackpotTester.playing:
			$JackpotTester.stop()
	
	if Input.is_action_just_pressed("take_damage"):
			## killbind for testing
		_on_hazard_a_hazard_a_miss()
		#pass
	
	if Input.is_action_just_pressed("debugging_score_up"):
		score += 100
	
	#score_label.text = str("123456789")
	"""
	CHANGE THE MISS VALUE HERE TO TEST
	"""

	## print(int(player_miss_timer.time_left))
	main_style_value = $StyleMeterRoot.style_value
	
	#print("global results snapshot was ", GlobalVariables.results_snapshot)
	
	pass


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
	#print(10 - timer_bonus)
	four_times_bonus_counter += 1
	if four_times_bonus_counter == 4:
		four_times_bonus_counter = 0
		score += four_times_bonus_score
		$RoundBonusText.show_round_bonus()
		GlobalVariables.end_four_round_complete_bonus_total += four_times_bonus_score
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
	score += 20

#func _on_hazards_miss() -> void:
	#miss += 1
	## print("main miss detected")


func _on_player_nova_blast() -> void:
	round_timer_stop.emit()
	await get_tree().create_timer(0.1).timeout
	can_collide_master = true

func _on_hazard_a_hazard_a_miss() -> void:
	GlobalVariables.results_snapshot = score
	round_timer_stop.emit()
	miss += 1
	_miss()
	## print("returned from _miss() function to A miss")
	can_collide_master = false
	Player.miss_function()
	await get_tree().create_timer(1.8).timeout
	can_collide_master = true
	if miss < 3:
		_round_timer_start()


func _on_hazard_b_hazard_b_miss() -> void:
	## this one is vestigial. Left in to not break overlooked scripting
	miss += 1
	_miss()
	Player.miss_function()


func _miss() -> void:
	#print("Oh no! Player lost ", coin_bonus, " coins!")
	GlobalVariables.music_player_boolean = true
	GlobalVariables.results_snapshot = score
	GlobalVariables.coin_snapshot = coin_bonus + 1
	GlobalVariables.coin_counter_tracker_global = 1
	##$MissSound.play()
	#print("global coin snap on line 179 was", GlobalVariables.coin_snapshot)
	coin_bonus = 0
	#print("global coin snap on line 181 was", GlobalVariables.coin_snapshot)
	if miss == 1:
		if score < 1000:
			GlobalVariables.a_plus_tripwire = false
		Bomb3.bomb_blow()
	if miss == 2:
		Bomb2.bomb_blow()
	if miss == 3:
		Bomb1.bomb_blow()
		game_over_screen.show()
		game_over.emit()
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
	GlobalVariables.a_plus_tripwire = true
	game_over_screen.hide()
	miss = 0
	four_times_bonus_counter = 0
	score = 0
	round_timer_start.emit()
	Bomb3.bomb_reset()
	Bomb2.bomb_reset()
	Bomb1.bomb_reset()


func _on_round_meter_main_round_timer_timeout() -> void:
	round_timer_stop.emit()
	_on_hazard_a_hazard_a_miss()
