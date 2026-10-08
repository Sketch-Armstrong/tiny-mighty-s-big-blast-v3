extends Node2D
@onready var ball_1 = $RigidBody2D
@onready var ball_2 = $RigidBody2D2
@onready var ball_3 = $RigidBody2D3
@onready var sprite_1 = $RigidBody2D/Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_button_pressed() -> void:
	ball_1.set_freeze_enabled(false)
	ball_1.apply_impulse(Vector2(-500, -500), Vector2(0, -50))

	#ball_2.set_freeze_enabled(false)
	#ball_2.apply_impulse(Vector2(randi_range(-1000, 1000), randi_range(0, 0)), Vector2(300, 0))
	#ball_3.set_freeze_enabled(false)
	#ball_3.apply_impulse(Vector2(randi_range(-1000, 1000), randi_range(0, 0)), Vector2(300, 0))
