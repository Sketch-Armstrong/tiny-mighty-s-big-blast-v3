extends Node2D

@onready var coin_count_text = $Node2D/CoinCountTextControl/CoinCountTextLabel
@onready var coin_count_player = $CoinCountTextAnimationPlayer
@onready var coin_loss_value := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#show_coin_loss()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func show_coin_counter():
	coin_count_text.text = str(GlobalVariables.coin_counter_tracker_global)
	coin_count_player.play("show_count")
