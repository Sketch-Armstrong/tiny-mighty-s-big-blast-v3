extends Node2D

@onready var BCAnimationPlayer := $BouncyCoinAnimationPlayer
signal hazard_coin_created
signal hazard_coin_destroyed

signal coin_grabbed_batonpass_1

func _ready() -> void:
	BCAnimationPlayer.play("Coin_Bounce")
	pass

func created() -> void:
	GlobalVariables.hazard_count += 1

func destroyed() -> void:
	BCAnimationPlayer.pause()
	#print("BCanimation player did pause")
	GlobalVariables.hazard_count -= 1
	queue_free()


func _on_bouncy_coin_coin_grabbed() -> void:
	coin_grabbed_batonpass_1.emit()
	print("baton pass 1 emitted")
