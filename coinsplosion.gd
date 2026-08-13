extends Node2D

## \\\\ the coins use fighting game numpad notation \\\\

@onready var splosion_player = $CoinCascadePlayer
@onready var spin_player = $CoinSpinPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#splosion_player.play ("coinsplosion")
	#spin_player.play("coins_spin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func coinsplode() -> void:
	$CoinLossText.show_coin_loss()
	splosion_player.play("coinsplosion")
	spin_player.play("coins_spin")

func reset_coins() -> void:
	splosion_player.play("RESET")
