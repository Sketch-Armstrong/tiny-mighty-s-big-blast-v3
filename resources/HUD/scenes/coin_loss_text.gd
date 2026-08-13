extends Node2D

@onready var coin_loss_text = $Node2D/CoinLossTextControl/CoinLossTextLabel
@onready var coin_loss_player = $CoinLossTextAnimationPlayer
@onready var coin_loss_value := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#show_coin_loss()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func show_coin_loss():
	coin_loss_text.text = str(GlobalVariables.coin_snapshot, " → 0")
	coin_loss_player.play("show_loss")
