extends Node2D

#@onready var round_timer_value = $RoundTimer.get_time_left()
@onready var clear_timer := $"../Toggler/Control/ClearTimer"
@onready var clear_progress_bar = $Sprite2D/Control/ClearProgressBar



func _process(delta: float) -> void:
	var rounded_timer_value = clear_timer.get_time_left()
	clear_progress_bar.value = rounded_timer_value
