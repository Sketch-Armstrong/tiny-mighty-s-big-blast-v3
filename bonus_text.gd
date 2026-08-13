extends Node2D

@onready var bonus_text = $Node2D/BonusTextControl/BonusTextLabel
@onready var bonus_player = $BonusTextAnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_text():
	var timer_bonus = GlobalVariables.timer_bonus_global
	var coin_bonus = GlobalVariables.coin_bonus_global
	round(timer_bonus)
	bonus_text.text = str("+   ",coin_bonus," x    ",timer_bonus)
	bonus_player.play("show_bonus")
