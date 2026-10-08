extends Node2D

@onready var caution_player = $CautionAnimationPlayer
@onready var caution_tape = $CautionTape2D
@onready var caution_tape2 = $CautionTape2D2
@onready var caution_tape3 = $CautionTape2D3
@export var caution_rotation := 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#caution_sprite.rotation = caution_rotation

func caution_animation() -> void:
	caution_tape.rotation = randf_range(-0.1, 0.1)
	caution_tape2.rotation = randf_range(-0.1, 0.1)
	caution_tape3.rotation = randf_range(-0.1, 0.1)
	
	caution_player.play("caution_tape")
