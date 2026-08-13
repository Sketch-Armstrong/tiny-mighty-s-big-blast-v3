extends State
class_name FourthState

#===========
# SPOT 1 OF 3
# _ _ O
#===========

@onready var player := get_parent().get_parent()
@onready var dash_animation_test = player.dash_animation
@onready var idle_animation = player.idle_animation
@onready var idle_sprites = player.idle_sprites

func _ready() -> void:
	idle_sprites.visible = true
	player.global_position = Vector2(900, 500)
	player.can_move = false
	player.start_move_timer()
	player.tiny_sprites.set_frame(3)


func _process(delta: float) -> void:

	if Input.is_action_just_pressed("tiny_move_left") and player.can_move == true:
		idle_sprites.visible = false
		player.global_position = Vector2(600, 500)
		dash_animation_test.play("dash_flip")
		await dash_animation_test.animation_finished
		get_parent().change_state("third")

	elif Input.is_action_just_pressed("tiny_move_right") and player.can_move == true:
		idle_sprites.visible = false
		get_parent().change_state("victory")
		
