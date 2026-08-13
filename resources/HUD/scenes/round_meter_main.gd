extends Node2D

#@onready var round_timer_value = $RoundTimer.get_time_left()
@onready var round_timer := $RoundTimer
@onready var progress_bar = $Control/ProgressBar
@onready var timer_bomb := $TimerBomb
@onready var meter_coin := $MeterCoin
@onready var coin_mult_text := $CoinMult


signal round_timer_timeout

func _ready() -> void:
	pass # Replace with function body.
	#$ProgressBar.value = 75


func _process(delta: float) -> void:
	var round_timer_value = $RoundTimer.get_time_left()
	#print(round_timer_value)
	var coin_mult_num = 11 - round_timer_value
	progress_bar.value = round_timer_value
	
	coin_mult_text.set_frame(coin_mult_num)

func _start_round_timer() -> void:
	round_timer.start()
	round_timer.set_paused(false)



func _on_player_player_reset() -> void:
	#round_timer.set_paused(false)
	#round_timer.start()
	pass



func _on_player_player_nova_blast() -> void:
	round_timer.set_paused(true)


func _on_main_game_start() -> void:
	_start_round_timer()


func _on_round_timer_timeout() -> void:
	round_timer_timeout.emit()



func _on_main_round_timer_stop() -> void:
	round_timer.set_paused(true)


func _on_main_round_timer_start() -> void:
	_start_round_timer()


func _on_main_game_over() -> void:
	round_timer.set_paused(true)
