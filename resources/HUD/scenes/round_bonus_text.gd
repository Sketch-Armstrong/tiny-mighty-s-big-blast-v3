extends Node2D

@onready var bonus_text = $Node2D/RoundBonusTextControl/RoundBonusTextLabel
@onready var bonus_player = $RoundBonusTextAnimationPlayer
@onready var bonus_value := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	set_round_bonus_value(GlobalVariables.four_round_complete_bonus_global)
	#show_round_bonus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_round_bonus_value(passed_value):
	bonus_value = passed_value

func show_round_bonus():
	bonus_text.text = str("+",bonus_value)
	bonus_player.play("show_bonus")
