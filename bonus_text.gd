extends Node2D

@onready var timer_bonus_label = $Node2D/BonusTextControl/TimerBonusTextLabel
@onready var coin_bonus_label = $Node2D/BonusTextControl/CoinBonusTextLabel2
@onready var timer_bonus
@onready var coin_bonus

@onready var bonus_player = $BonusTextAnimationPlayer

func _ready() -> void:
	pass # Replace with function body.

func update_text():
	timer_bonus = GlobalVariables.timer_bonus_global
	coin_bonus = GlobalVariables.coin_bonus_global
	round(timer_bonus)
	timer_bonus_label.text = str(timer_bonus)
	coin_bonus_label.text = str(coin_bonus)
	bonus_player.play("show_bonus")
