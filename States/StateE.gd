extends State
class_name FifthStateVictory

#===========
# VICTORY STATE AT END
# _ _ _ X
#===========

@onready var player := get_parent().get_parent()
@onready var explosion_animation_state_E = player.explosion_animation
@onready var idle_animation = player.idle_animation
@onready var idle_sprites = player.idle_sprites
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#player.global_position = Vector2(00, 600)
	player.explosion_sprites.visible = true
	player.tiny_sprites.visible = false
	explosion_animation_state_E.play("explosion")
	await explosion_animation_state_E.animation_finished
	player.player_increment_score()
	get_parent().change_state("start")
	#play BLAST animation
	#add NORMAL_VICTORY_AMOUNT + COLLECTED_COINS_VALUE to score
	#set state to START
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("tiny_move_left"):
		#get_parent().change_state("fourth")
	pass
