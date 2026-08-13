extends Node

@onready var rank_player := $StyleRankings/RankingsAnimationPlayer
@onready var style_label := $StyleMeterLabel
@onready var style_button := $StyleMeterButton
@onready var style_timer := $StyleTimer
@onready var style_bar := $ProgressBar
@onready var style_value := 0
#repeated move penalties
@onready var right_penalty := 0
@onready var left_penalty := 0
@onready var half_right_penalty := 0
@onready var half_left_penalty := 0
@onready var taunt_penalty := 0
@onready var hop_penalty := 0
@onready var down_penalty := 0
@onready var near_miss_penalty := 0
#timers
@onready var right_timer := $RightTimer
@onready var left_timer := $LeftTimer
@onready var h_r_timer := $HalfRightTimer
@onready var h_l_timer := $HalfLeftTimer
@onready var hop_timer := $HopTimer
@onready var taunt_timer := $TauntTimer
@onready var down_timer := $DownTimer
@onready var near_miss_timer := $NearMissTimer

@onready var can_count := true

signal rank_s
signal rank_a
signal rank_b
signal rank_c
signal rank_d

##======
## when doing more complex characters, all of these would be in said character's 
## various states for moves and actions
## this is just a rough and dirty way of doing it, instead of using any complex create_child()
## sorts of code
##======

func _ready() -> void:
	#style_bar.is_percentage_shown(true)
	style_bar.set_show_percentage(true)
	clamp(style_value, 0, 105)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	style_bar.value = style_value
	
	if style_value >= 80: 
		style_label.text = "Seismic"
		rank_player.play("SEISMIC")
		rank_s.emit()
		GlobalVariables.style_meter_rank = 5
		return
	
	if style_value >= 60 and style_value < 80:
		style_label.text = "Atomic"
		rank_player.play("ATOMIC")
		rank_a.emit()
		GlobalVariables.style_meter_rank = 4
		return
	
	if style_value >= 40 and style_value < 60:
		style_label.text = "Blasting"
		rank_player.play("BLASTING")
		rank_b.emit()
		GlobalVariables.style_meter_rank = 3
		return
	
	if style_value >= 20 and style_value < 40:
		style_label.text = "Crashing"
		rank_player.play("CRASHING")
		rank_c.emit()
		GlobalVariables.style_meter_rank = 2
		return
	
	if style_value >= 0 and style_value < 20:
		style_label.text = "Dud"
		rank_player.play("DUD")
		rank_d.emit()
		GlobalVariables.style_meter_rank = 1
		return

func _style_up(bonus_penalty: int) -> void:
	style_value += (10 - bonus_penalty)

func _right_style_cooldown() -> void:
	right_timer.start()
	right_penalty += 1
	if right_penalty > 5:
		right_penalty = 5
	else:
		_style_up(right_penalty)
func _on_right_timer_timeout() -> void:
	if right_penalty > 1:
		right_penalty -= 1
	else:
		pass

func _left_style_cooldown() -> void: 
	left_timer.start()
	left_penalty += 1
	if left_penalty > 5:
		left_penalty = 5
	else:
		_style_up(left_penalty)
func _on_left_timer_timeout() -> void:
	if left_penalty > 1:
		left_penalty -= 1
	else:
		pass

func _half_right_style_cooldown() -> void:
	h_r_timer.start()
	half_right_penalty += 1
	if half_right_penalty > 5:
		half_right_penalty = 5
	else:
		_style_up(half_right_penalty)
func _on_half_right_timer_timeout() -> void:
	if half_right_penalty > 1:
		half_right_penalty -= 1
	else:
		pass

func _half_left_style_cooldown() -> void:
	h_l_timer.start()
	half_left_penalty += 1
	if half_left_penalty > 5:
		half_left_penalty = 5
	else:
		_style_up(half_left_penalty)
func _on_half_left_timer_timeout() -> void:
	if half_left_penalty > 1:
		half_left_penalty -= 1
	else:
		pass

func _hop_style_cooldown() -> void:
	hop_timer.start()
	hop_penalty += 1
	if hop_penalty > 5:
		hop_penalty = 5
	else:
		_style_up(hop_penalty)
func _on_hop_timer_timeout() -> void:
	if hop_penalty > 1:
		hop_penalty -= 1
	else:
		pass

func _taunt_style_cooldown() -> void:
	taunt_timer.start()
	taunt_penalty += 1
	if taunt_penalty > 5:
		taunt_penalty = 5
	else:
		_style_up(taunt_penalty)

func _on_taunt_timer_timeout() -> void:
	if taunt_penalty > 1: 
		taunt_penalty -= 1
	else:
		pass

func _down_style_cooldown() -> void:
	## # print("donw spin signal recieved")
	down_timer.start()
	down_penalty += 1
	if down_penalty > 5:
		down_penalty = 5
	else:
		_style_up(down_penalty)

func _on_down_timer_timeout() -> void:
	if down_penalty > 1:
		down_penalty -= 1
	else: 
		pass

func _near_miss_style_cooldown() -> void:
	near_miss_timer.start()
	near_miss_penalty += 1
	if near_miss_penalty > 5:
		near_miss_penalty = 5
	else:
		_style_up(near_miss_penalty)

func _on_near_miss_timer_timeout() -> void:
	if near_miss_penalty > 1:
		near_miss_penalty -= 1
	else:
		pass


##=========
##YOU NEED A GIGA TIMER RESET FUNCTION, THAT RESETS EVERY TIMER UPON NOVA BLAST
##=========

func timers_reset() -> void:
	right_timer.start()
	left_timer.start()
	h_r_timer.start()
	h_l_timer.start()
	hop_timer.start()
	taunt_timer.start()
	down_timer.start()
	near_miss_timer.start()

func penalties_reset() -> void:
	right_penalty = 0
	left_penalty = 0
	half_right_penalty = 0
	half_left_penalty = 0
	taunt_penalty = 0
	hop_penalty = 0
	down_penalty = 0
	near_miss_penalty = 0


func _on_style_timer_timeout() -> void:
	if can_count == true:
		style_value -= 1
func _on_style_meter_button_pressed() -> void:
	_style_up(1)
	#get_tree().paused = true
	### # print(style_bar.value)
func _on_player_style_test() -> void:
	_style_up(1)


func _on_main_style_on() -> void:
	style_value = 0
	penalties_reset()
	timers_reset()
	can_count = true


func _on_main_style_off() -> void:
	can_count = false
