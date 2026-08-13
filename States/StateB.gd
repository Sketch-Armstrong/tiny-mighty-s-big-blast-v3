extends State
class_name SecondState

#===========
# SPOT 1 OF 3
# O _ _
#===========

@onready var player = get_parent().get_parent()
@onready var dash_animation_test = player.dash_animation
@onready var idle_animation = player.idle_animation
@onready var idle_sprites = player.idle_sprites

func _ready() -> void:
	player.global_position = Vector2(300, 500)
	player.can_move = false
	player.start_move_timer()
	player.tiny_sprites.set_frame(1)
	


func _tiny_move_right() -> void:
	if idle_sprites.visible == true:
		idle_sprites.visible = false
	dash_animation_test.play("dash")
	await dash_animation_test.animation_finished



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("tiny_move_right") and player.can_move == true:
		_tiny_move_right()
		player.global_position = Vector2(600, 500)
		get_parent().change_state("third")
