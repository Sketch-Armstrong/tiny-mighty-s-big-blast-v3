extends State
class_name FirstStateStart

#===========
# START STATE
#===========

@onready var player = get_parent().get_parent()
@onready var dash_animation_test = player.dash_animation
@onready var dash_sprites = player.dash_sprites
@onready var idle_animation_player = player.idle_animation
@onready var idle_sprites = player.idle_sprites
@onready var icon = player.icon
@onready var main_scene = player.main_scene


#window resolution is restricted/set to 700 x 1200


func _ready() -> void:
	
	player.global_position = Vector2(100, 500)
	player.move_timer.start()
	player.explosion_sprites.visible = false
	await get_tree().create_timer(5.0).timeout
	main_scene.increment_score()


func _move_tiny_right() -> void:
		#idle_sprites.visible = false
		#idle_animation_player.stop()
		icon.visible = false

		dash_animation_test.play("dash")
		await dash_animation_test.animation_finished
		dash_sprites.visible = false
		#icon.visible = true
		#await get_tree().create_timer(2.0).timeout
		print("LINE ABOVE SCORE +5 PROC'D")



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("tiny_move_right") and player.can_move == true:
		#idle_animation_player.play("RESET")
		_move_tiny_right()
		player.global_position = Vector2(300, 500)
		get_parent().change_state("second")
	
	else:
		idle_animation_player.play("idle")
		pass
	
