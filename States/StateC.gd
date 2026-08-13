extends State
class_name ThirdState

#===========
# SPOT 1 OF 3
# _ O _
#===========

@onready var player := get_parent().get_parent()
@onready var dash_animation_test = player.dash_animation
@onready var idle_animation = player.idle_animation
@onready var idle_sprites = player.idle_sprites
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	player.global_position = Vector2(600, 500)
	player.can_move = false
	player.start_move_timer()
	player.tiny_sprites.set_frame(2)
	idle_sprites.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("tiny_move_left") and player.can_move == true:
		idle_sprites.visible = false
		player.global_position = Vector2(300, 500)
		dash_animation_test.play("dash_flip")
		await dash_animation_test.animation_finished
		get_parent().change_state("second")

	elif Input.is_action_just_pressed("tiny_move_right") and player.can_move == true:
		idle_sprites.visible = false
		player.global_position = Vector2(900, 500)
		dash_animation_test.play("dash")
		await dash_animation_test.animation_finished
		get_parent().change_state("fourth")
