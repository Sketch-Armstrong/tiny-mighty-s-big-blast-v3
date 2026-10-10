extends Label
@onready var game_timer: int
var start_boolean: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_boolean = false
	$AnimationPlayer.play("align_text")
	await get_tree().process_frame
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	set_time()
	GlobalVariables.time_left_global = roundi($GameTimer.time_left)
	#print(str(GlobalVariables.time_left_global))
	

func set_time() -> void: 
	game_timer = round($GameTimer.time_left)
	var game_timer_seconds = game_timer % 60
	if game_timer_seconds >= 10:
		@warning_ignore("integer_division")
		self.text = str(game_timer/60) + ":" + str(game_timer_seconds)
	if game_timer_seconds < 10:
		@warning_ignore("integer_division")
		self.text = str(game_timer/60) + ":0" + str(game_timer_seconds)


func _on_main_game_start() -> void:
	start_boolean = true
