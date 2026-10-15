extends CharacterBody2D
#

#===========
# PLAYER SCENE
#===========

var global
var state
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var position_counter := 0

@onready var move_timer := $MoveTimer

@onready var can_move: bool = false
@export var spawn_point: Vector2
@onready var main_scene = get_parent()
@onready var position_vector := Vector2(0, 0)
@onready var player_animation_player := $EverythingAnimationPlayer
@onready var tiny_collision := $CollisionShape2D
#@onready var tiny_collision_pos = $CollisionShape2D.global_position
@onready var taunt_timer := $TauntTimer
@onready var near_miss_collision := $NearMissDetector
@onready var tiny_collision_pos = $CollisionShape2D.global_position
@onready var near_miss_boolean: bool = false
@onready var near_miss_main_lanes := $NearMissMainLanes
@onready var near_miss_hop := $NearMissHop
@onready var near_miss_boolean_main: bool = false
@onready var miss_sprites := $MissSprites
@onready var down_taunt_boolean := false
@onready var sound_fx_test := $SoundEffectTester
@onready var lives_player := 0
@onready var _default_mask = collision_mask
@onready var _default_layer: int

@onready var ULTIMATE_CAN_MOVE := true


signal style_test

signal player_reset
signal player_nova_blast
signal player_nova_blast_finished
signal player_miss

signal right
signal left
signal half_right
signal half_left
signal taunt
signal taunt_release
signal hop
signal down_spin
signal BRUTE_FORCE_TAUNT_PRESSED
signal BRUTE_FORCE_TAUNT_RELEASE

signal near_miss


func _ready() -> void:
	_default_mask = collision_mask
	_default_layer = collision_layer
	self.global_position = spawn_point
	move_timer.start()
	near_miss_collision.enabled = true
	player_animation_player.play("Intro_Bounce")
	taunt_timer.stop()
	ULTIMATE_CAN_MOVE = false
	await get_tree().create_timer(1.7).timeout
	ULTIMATE_CAN_MOVE = true


@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	
	
	if GlobalVariables.tiny_visible == false:
		self.hide()
	if GlobalVariables.tiny_visible == true:
		self.show()

	
	
	if ULTIMATE_CAN_MOVE == true:
		_parent_move_state()

		if player_animation_player.current_animation == "Dash" or "Dash_Flip" or "Half_Dash" or "Half_Dash_Flip" or "Short_Hop" and player_animation_player.is_playing():
			if near_miss_collision.is_colliding() == true:
				# # # print("near miss middle lanes worked")
				near_miss.emit()
				near_miss_collision.enabled = false
				await player_animation_player.animation_finished
				near_miss_boolean = true
				near_miss_collision.enabled = true
				
					##============
					## NEAR MISS MAIN STILL HITS AFTER A "MISS" LIFE LOST
					##============
				
			if near_miss_main_lanes.is_colliding() == true:
				near_miss.emit()
				# # # print("near miss main lanes worked")
				near_miss_main_lanes.enabled = false
				await player_animation_player.animation_finished
				near_miss_boolean_main = true
				near_miss_main_lanes.enabled = true
				
			
			if near_miss_hop.is_colliding() == true:
				near_miss.emit()
				# # # print("near miss hop worked")
				near_miss_hop.enabled = false
				await player_animation_player.animation_finished
				near_miss_hop.enabled = true

		if Input.is_action_just_pressed("taunt"):
			BRUTE_FORCE_TAUNT_PRESSED.emit()
			# # # print("taunt button pressed")

		if Input.is_action_just_released("taunt"):
			# # # print("taunt button released")
			BRUTE_FORCE_TAUNT_RELEASE.emit()
	
	else:
		pass
	
	

func disable_collision_mask() -> void:
	set_deferred("collision_mask", 0)

func restore_collision_mask() -> void:
	set_deferred("collision_mask", _default_mask)

func disable_collision_layers() -> void:
	set_deferred("collision_layer", 0)

func restore_collision_layers() -> void:
	set_deferred("collision_layer", _default_layer)


func _parent_move_state() -> void:
	
	_idle()


func _idle() -> void:
	

	if player_animation_player.is_playing() == false:
		player_animation_player.play("Idle")
	
	if Input.is_action_pressed("taunt") and can_move == true:
		_taunt()
	elif Input.is_action_just_released("taunt"):
		return
	elif Input.is_action_just_pressed("tiny_move_right") and can_move == true:
		_move_right()
	elif Input.is_action_just_pressed("tiny_move_left") and can_move == true:
		_move_left()


func _move_right() -> void:
	if Input.is_action_just_pressed("tiny_move_right") and self.can_move == true and position_counter == 3:
		_nova_blast()
	else:
		can_move = false
		
		_increment_counter()
		right.emit()
		sound_fx_test.play()
		player_animation_player.play("Dash")
		self.position.x += 300
		await player_animation_player.animation_finished
		can_move = true
		await get_tree().process_frame
		_idle()

func _move_left() -> void:
	if position_counter <= 1:
		player_animation_player.queue("Idle")
		return
	else:
		can_move = false
		_deincrement_counter()
		left.emit()
		sound_fx_test.play()
		self.position.x -= 300
		player_animation_player.play("Dash_Flip")
		await player_animation_player.animation_finished
		can_move = true
		await get_tree().process_frame
		_idle()


func _taunt() -> void:
	
	if Input.is_action_pressed("taunt") and can_move == true:
		
		
		player_animation_player.play("Pullback")
		
		if Input.is_action_just_pressed("tiny_move_right") and can_move == true:
				player_animation_player.stop()
				_half_dash()
		if Input.is_action_just_pressed("tiny_move_left") and can_move == true:
			player_animation_player.stop()
			_half_dash_flip()
		if Input.is_action_just_pressed("tiny_move_up") and can_move == true:
			player_animation_player.stop()
			_short_hop()
		if Input.is_action_just_pressed("tiny_move_down") and can_move == true:
			player_animation_player.stop()
			_down_taunt()


func _on_brute_force_taunt_pressed() -> void:
	taunt.emit()
	taunt_timer.start()

func _on_brute_force_taunt_release() -> void:
	print("taunt button regular released")
	taunt_release.emit()
	taunt_timer.stop()
	if player_animation_player.current_animation == "Pullback":
		player_animation_player.stop()
		_idle()


func _short_hop() -> void:
	can_move = false
	hop.emit()
	
	player_animation_player.play("Short_Hop")
	
	await player_animation_player.animation_finished
	can_move = true
	player_animation_player.play("Idle")

func _down_taunt() -> void:
	can_move = false
	down_spin.emit()
	
	player_animation_player.play("Down_Taunt")
	await player_animation_player.animation_finished
	can_move = true 
	player_animation_player.play("Idle")



func _half_dash() -> void:
	can_move = false
	half_right.emit()
	
	player_animation_player.play("Half_Dash")
	await player_animation_player.animation_finished
	can_move = true
	player_animation_player.play("Idle")

func _half_dash_flip() -> void:
	can_move = false
	half_left.emit()
	
	player_animation_player.play("Half_Dash_Flip")
	await player_animation_player.animation_finished
	can_move = true
	player_animation_player.play("Idle")

func _nova_blast() -> void:
	
	main_scene.can_collide_master_off()
	player_nova_blast.emit()
	tiny_collision.disabled = true
	can_move = false
	main_scene.update_bonus_label()
	#$NovaBlastPlayer.play()
		## add a diceroll later for if this or the others, or any at all, play
	player_animation_player.play("Explosion")
	await player_animation_player.animation_finished
	self.global_position = spawn_point
	reset_tiny()
	main_scene._on_player_nova_blast()
	main_scene.increment_score()
	player_nova_blast_finished.emit()

func _increment_counter() -> void:
	position_counter += 1
	## # # print(position_counter)

func _deincrement_counter() -> void:
	position_counter -= 1
	## # # print(position_counter)

func play_game_over_sound() -> void:
	$Audio/DeathSound4/GOVER_player.play("game_over_sound")
	return
		## was going to originally dummy this out, but I left it in on the off chance I wanted to
		## do extra stuff on a game over

func miss_function() -> void:
	GlobalVariables.miss_active = true
	can_move = false
	player_miss.emit()

	if GlobalVariables.lives_global == 1:
		play_game_over_sound()
		if GlobalVariables.lives_global == 1:
			tiny_collision.set_deferred("disabled", true)
			tiny_collision_pos = $CollisionShape2D.global_position
			miss_sprites.global_position = tiny_collision_pos
			$Coinsplosion.global_position = tiny_collision_pos
			player_animation_player.call_deferred("stop")
			player_animation_player.call_deferred("play", "miss_game_over")
			await player_animation_player.animation_finished
	
	if GlobalVariables.lives_global > 1:
		tiny_collision.set_deferred("disabled", true)
		tiny_collision_pos = $CollisionShape2D.global_position
		miss_sprites.global_position = tiny_collision_pos
		$Coinsplosion.global_position = tiny_collision_pos
		player_animation_player.call_deferred("stop")
		player_animation_player.call_deferred("play", "miss")
		await player_animation_player.animation_finished
	
	#self.global_position = spawn_point
	reset_tiny()
	#tiny_collision.set_deferred("disabled", false)

#func display_coin_count():
	#$Coinsplosion/Sprite2D.global_position = tiny_collision_pos

func reset_tiny() -> void:
	if tiny_collision.disabled == false:
		tiny_collision.set_deferred("disabled", true)
	# # # print("tiny reset")
	self.global_position = spawn_point
	
	position_counter = 0
	can_move = true
	player_animation_player.play("RESET")
	player_reset.emit()
	GlobalVariables.music_player_boolean = false
	GlobalVariables.miss_active = false
	_idle()
	## ============
	## include the timers giga reset here
	## ============

func game_over_stop_player() -> void:
	disable_collision_layers()
	disable_collision_mask()
	can_move = false
	#ULTIMATE_CAN_MOVE = false
	if player_animation_player.current_animation == "Explosion":
		await player_animation_player.animation_finished
		player_animation_player.play("Idle")
		self.global_position = spawn_point
		#ULTIMATE_CAN_MOVE = false
		position_counter = 0
		_idle()
	elif player_animation_player.current_animation == "Miss":
		await player_animation_player.animation_finished
		player_animation_player.play("Idle")
		self.global_position = spawn_point
		#ULTIMATE_CAN_MOVE = false
		position_counter = 0
		_idle()
	
	else:
		await player_animation_player.animation_finished
		player_animation_player.play("Idle")
		self.global_position = spawn_point
		#ULTIMATE_CAN_MOVE = false
		position_counter = 0
		_idle()
	pass

func can_move_on() -> void:
	can_move = true

func can_move_off() -> void:
	can_move = false



func hazard_collision_on() -> void:
	main_scene.can_collide_master_on()

func start_move_timer():
	move_timer.start()

func _on_move_timer_timeout() -> void:
	can_move = true



func _on_round_timer_timeout() -> void:
	main_scene._on_hazard_a_hazard_a_miss()

func player_increment_score():
	main_scene.increment_score()

func player_near_miss():
	main_scene.near_miss()


func _on_main_game_over() -> void:
	ULTIMATE_CAN_MOVE = false


func _on_game_over_retry() -> void:
	restore_collision_layers()
	restore_collision_mask()
	ULTIMATE_CAN_MOVE = true


func show_coin_count() -> void:
	$CollisionShape2D/CoinCountText.show_coin_counter()


func _on_near_miss() -> void:
	print("near missed")
	$NearMissSoundPlayer.play()
	main_scene.near_miss()
