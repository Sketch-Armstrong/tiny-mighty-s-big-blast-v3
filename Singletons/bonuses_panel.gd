extends Control

@onready var coins_label := $CoinsLabel
@onready var rounds_label := $RoundsLabel
@onready var timer_label := $TimerLabel
@onready var coin_timer_label := $CoinTimerLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	coins_label.text = str(GlobalVariables.end_coin_bonus_total)
	timer_label.text = str(GlobalVariables.end_timer_bonus_total)
	coin_timer_label.text = str(GlobalVariables.end_coin_and_timer_bonuses_total)
	rounds_label.text = str(GlobalVariables.end_four_round_complete_bonus_total)
