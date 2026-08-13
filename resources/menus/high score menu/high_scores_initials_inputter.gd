extends Node2D
@onready var label1 = $InitialLabel1
@onready var char_number := 65
@onready var progress_counter := 0

@onready var initial_1 := ""
@onready var initial_2 := ""
@onready var initial_3 := ""
@onready var initials_combined := ""

#@onready var can_select = GlobalHighscoreHandler.global_initials_can_input


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clamp(char_number, 33, 126)   

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	var can_select = GlobalHighscoreHandler.global_initials_can_input
	if can_select == true: 
		GlobalVariables.can_retry = false
		GlobalVariables.can_quit = false
		
		self.show()
		if Input.is_action_just_pressed("tiny_move_left") or Input.is_action_just_pressed("tiny_move_down"):
			if char_number == 33:
				char_number = 126
				return
			char_number -= 1
		if Input.is_action_just_pressed("tiny_move_right") or Input.is_action_just_pressed("tiny_move_up"):
			if char_number == 126:
				char_number = 33
				return
			char_number += 1
		#label1.text = String.chr(char_number)
		
		if Input.is_action_just_pressed("taunt"):
			select_char()
		label1.text = initials_combined + String.chr(char_number)
	if can_select == false:
		char_number = 65
		progress_counter = 0

func select_char() -> void:
	pass
	if progress_counter == 2:
		initials_combined += String.chr(char_number)
		print("should be proc'ing at 3 inputs and hitting a fourth ")
		initials_string_combine() 
		GlobalHighscoreHandler.global_initials_can_input = false
		return
	
	
	initials_combined += String.chr(char_number)
	progress_counter += 1
	
	print("select_char progress counter was ",progress_counter)
	return

func initials_string_combine() -> void:
	if GlobalHighscoreHandler.global_highscores_array_position == 0:
		return
	else:
		GlobalHighscoreHandler.global_initials_combined = initials_combined
		GlobalHighscoreHandler.update_highscore(GlobalHighscoreHandler.global_highscores_array_position)
		GlobalHighscoreHandler.save_game()
		GlobalHighscoreHandler.global_initials_can_input = false
		GlobalHighscoreHandler.global_initials_combined = ""
		initials_combined = ""
		progress_counter = 0
		char_number = 65
		self.hide()
		GlobalVariables.can_retry = true
		GlobalVariables.can_quit = true
		
		return
