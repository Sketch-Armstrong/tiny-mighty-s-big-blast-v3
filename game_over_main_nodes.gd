extends Node

func test() -> void:
	print("testing if this works")

func add_lives_to_score() -> void:
	pass
	print("global score before lives was: ", str(GlobalVariables.score_global))
	var lives_bonus = GlobalVariables.lives_global
	GlobalVariables.score_global += lives_bonus * 50
	print("global score after lives was: ", str(GlobalVariables.score_global))
	
