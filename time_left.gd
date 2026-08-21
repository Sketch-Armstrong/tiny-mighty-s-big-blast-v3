extends Label
@onready var game_timer: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	game_timer = round($GameTimer.time_left)
	var game_timer_seconds = game_timer % 60
	if game_timer_seconds >= 10:
		@warning_ignore("integer_division")
		self.text = str(game_timer/60) + ":" + str(game_timer_seconds)
	if game_timer_seconds < 10:
		@warning_ignore("integer_division")
		self.text = str(game_timer/60) + ":0" + str(game_timer_seconds)
	
