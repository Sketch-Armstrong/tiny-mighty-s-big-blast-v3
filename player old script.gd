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
@onready var round_timer := $RoundTimer
@onready var can_move: bool = false
@export var spawn_point: Vector2
@onready var main_scene = get_parent()
@onready var position_vector := Vector2(0, 0)
@onready var player_animation_player := $EverythingAnimationPlayer
@onready var tiny_collision := $CollisionShape2D
@onready var taunt_timer := $TauntTimer
@onready var near_miss_collision := $NearMissDetector
@onready var near_miss_boolean: bool = false
@onready var near_miss_main_lanes := $NearMissMainLanes
@onready var near_miss_boolean_main: bool = false


func _ready() -> void:
	self.global_position = spawn_point
	move_timer.start()
	near_miss_collision.enabled = true

func _physics_process(delta: float) -> void:
	
	#if near_miss_collision.is_colliding():
		#print("near miss detector worked")
	


	
	
	if player_animation_player.current_animation == "Dash" or "Dash_Flip" and player_animation_player.is_playing():
		if near_miss_collision.is_colliding() == true:
			print("near miss ray collided")
			near_miss_collision.enabled = false
			await player_animation_player.animation_finished
			near_miss_boolean = true
			near_miss_collision.enabled = true
		pass
		if near_miss_main_lanes.is_colliding() == true:
			print("near miss detector worked")
			near_miss_main_lanes.enabled = false
			await player_animation_player.animation_finished
			near_miss_boolean_main = true
			near_miss_main_lanes.enabled = true
	
	
	
	if player_animation_player.current_animation == "Idle":
		tiny_collision.disabled = false
		if near_miss_boolean == true and position_counter >= 1:
			player_near_miss()
			near_miss_boolean = false
		
		elif near_miss_boolean_main == true and position_counter >= 1:
			player_near_miss()
			near_miss_boolean_main = false
		
		elif near_miss_boolean == true and position_counter == 0:
			near_miss_boolean = false
		
		elif near_miss_boolean_main == true and position_counter == 0:
			near_miss_boolean_main = false
	
	if Input.is_action_just_pressed("tiny_move_right") and position_counter == 0:
		round_timer.set_paused(false)
		start_round_timer()
	
	if Input.is_action_just_pressed("taunt") and position_counter < 1:
		return
	
	if Input.is_action_just_pressed("taunt") and can_move == true and position_counter >= 1:
		taunt_timer.start()
	
	if Input.is_action_pressed("taunt") and can_move == true and position_counter >= 1:
		can_move = false
		#if player_animation_player.is_playing() == true:
			#await player_animation_player.animation_finished
		player_animation_player.play("Pullback")
	
	if Input.is_action_just_released("taunt"):
		player_animation_player.stop()
		taunt_timer.stop()
		can_move = true
	

	if Input.is_action_just_pressed("tiny_move_left") and self.can_move == true and position_counter <= 1:
		return
	
	if Input.is_action_just_pressed("tiny_move_right") and self.can_move == true and position_counter == 3:
		tiny_collision.disabled = true
		round_timer.set_paused(true)
		player_animation_player.play("Explosion")
		await player_animation_player.animation_finished
		reset_tiny()
		main_scene.increment_score()
		
		
	
	elif Input.is_action_just_pressed("tiny_move_right") and self.can_move == true:
		_increment_counter()
		_move_right()
	elif Input.is_action_just_pressed("tiny_move_left") and self.can_move == true:
		_deincrement_counter()
		_move_left()
		
	
	if(Input.is_anything_pressed()==false and player_animation_player.is_playing()==false):
		player_animation_player.play("Idle")



func _move_left() -> void:
	can_move = false
	self.position.x -= 300
	player_animation_player.play("Dash_Flip")
	await player_animation_player.animation_finished
	can_move = true
	return

func _move_right() -> void:
	can_move = false
	self.position.x += 300
	player_animation_player.play("Dash")
	await player_animation_player.animation_finished
	can_move = true
	return

func _increment_counter() -> void:
	position_counter += 1

func _deincrement_counter() -> void:
	position_counter -= 1

func reset_tiny() -> void:
	position_counter = 0
	stop_round_timer()
	self.global_position = spawn_point

func start_move_timer():
	move_timer.start()

func _on_move_timer_timeout() -> void:
	can_move = true

func start_round_timer() -> void:
	round_timer.start(10000.0)

func stop_round_timer() -> void:
	round_timer.stop()

func _on_round_timer_timeout() -> void:
	main_scene._on_hazard_a_hazard_a_miss()

func player_increment_score():
	main_scene.increment_score()

func player_near_miss():
	main_scene.near_miss()

func _on_taunt_timer_timeout() -> void:
	main_scene.taunt_bonus()
