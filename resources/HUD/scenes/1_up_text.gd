extends Node2D

@onready var extra_life_text = $"Node2D/1upBonusTextControl/1upBonusTextLabel"
@onready var extra_life_player = $"1upBonusTextAnimationPlayer"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func play_1up_animation() -> void:
	extra_life_player.play("show_1up")

func randomize_rotation():
	extra_life_text.rotation = randf_range(-0.2, 0.2)
