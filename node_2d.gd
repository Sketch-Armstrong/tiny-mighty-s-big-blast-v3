extends Node2D

func _ready() -> void:
	randomize()
	var test_receiver
	test_receiver = _coin_dice_roll()
	print(test_receiver)

func _coin_dice_roll() -> int:
	var result = randi_range(0, 1)
	return result
	pass
