extends Node2D

@onready var carrl_player := $CarrlAnimationPlayer
@onready var face_timer := $FaceTimer


func _ready() -> void:
	carrl_player.play("Neutral")
	face_timer.timeout.connect(_on_timer_timeout)
	face_timer.start()

func _on_timer_timeout():
	if GlobalVariables.style_meter_rank <= 2:
		carrl_player.play("Negative")
		await carrl_player.animation_finished
		carrl_player.play("Neutral")
	elif GlobalVariables.style_meter_rank >= 4:
		carrl_player.play("Positive")
		await carrl_player.animation_finished
		carrl_player.play("Neutral")
	else:
		await carrl_player.animation_finished
		carrl_player.play("Neutral")
	pass
