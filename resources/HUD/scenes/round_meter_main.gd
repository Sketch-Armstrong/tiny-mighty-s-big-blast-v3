extends Node2D

#@onready var round_timer_value = $RoundTimer.get_time_left()
@onready var round_timer := $RoundTimer
@onready var progress_bar = $Control/ProgressBar
@onready var fuse: Node2D = $Fuse


signal round_timer_timeout

func _ready() -> void:
	$Fuse/FuseSprite.hide()
	$Fuse/AnimationPlayer.play("Fuse_Burn")
	pass # Replace with function body.
	#$ProgressBar.value = 75


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	var round_timer_value = $RoundTimer.get_time_left()
	progress_bar.value = round_timer_value
	var tex_size: Vector2 = progress_bar.texture_progress.get_size()
	var edge_local := Vector2(
		progress_bar.texture_progress_offset.x + tex_size.x * progress_bar.get_as_ratio(),
		progress_bar.texture_progress_offset.y + tex_size.y * 0.5  # vertical middle of the bar
	)
	fuse.global_position = progress_bar.get_global_transform() * edge_local




func _start_round_timer() -> void:
	round_timer.start()
	round_timer.set_paused(false)
	$Fuse/FuseSprite.show()


func _on_player_player_reset() -> void:
	#round_timer.set_paused(false)
	#round_timer.start()
	pass



func _on_player_player_nova_blast() -> void:
	round_timer.set_paused(true)


func _on_main_game_start() -> void:
	_start_round_timer()


func _on_round_timer_timeout() -> void:
	round_timer_timeout.emit()



func _on_main_round_timer_stop() -> void:
	round_timer.set_paused(true)

func _on_main_round_timer_actually_stop() -> void:
	round_timer.stop()


func _on_main_round_timer_start() -> void:
	_start_round_timer()


func _on_main_game_over() -> void:
	round_timer.set_paused(true)
