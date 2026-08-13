extends Node2D

signal miss
signal coin_grabbed_batonpass_2

@export var hazard_A_scene = preload("res://resources/Hazards/Scenes/hazard_a_test_subscene.tscn")
@export var hazard_B_scene = preload("res://resources/Hazards/Scenes/hazard_b_test_subscene.tscn")
@export var hazard_Coin_scene = preload("res://resources/Hazards/Scenes/bouncy_coin_shell.tscn")
#@export var hazard_Coin_scene = preload("res://resources/Hazards/Scenes/hazard_coin.tscn")


@export var hazard_A_gravity := 1.0
@export var hazard_B_gravity := 1.0
@export var hazard_C_gravity := 1.0
@onready var spawn_timer = $Timer
@onready var hazard_A := $HazardA
@onready var hazard_B := $HazardB
@onready var hazard_coin := $BouncyCoinShell
@onready var coin_timer := $CoinTimer

@export var hazard_one_spawn = Vector2(300, 0)
@export var hazard_two_spawn = Vector2(450, 0)
@export var hazard_three_spawn = Vector2(600, 0)
@export var hazard_four_spawn = Vector2(750, 0)
@export var hazard_five_spawn = Vector2(900, 0)
@onready var spawn_number = randi_range(1, 5)
@onready var last_spawn_number = 0
@onready var ULTIMATE_CAN_SPAWN := true

@onready var main_root_scene := get_parent()
@onready var can_collide_parent := true
@onready var style_number := 5
	#KISS, no need for an array or something complex with strings, when there's only style 5 ranks that increment, anyway





@onready var disable_2 := false
@onready var disable_1 := false
@onready var modulo_tracker := 5

@export var easy_fall_speed := 300.0
@export var medium_fall_speed := 350.0
@export var hard_fall_speed := 400.0

var hazards_count := GlobalVariables.hazard_count



func _ready() -> void:
	randomize()
	#inst_coin(hazard_four_spawn)

	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var hazards_count := GlobalVariables.hazard_count
	#print(hazards_count)
	if main_root_scene.can_collide_master == true: 
		can_collide_parent = true
	if main_root_scene.can_collide_master == false:
		can_collide_parent = false
		
		## vvv clunky, but there's no reason to engineer a better way since it's two booleans and 
		## will never go past like, 12 levels needing tracked
	if GlobalVariables.level_count_global == 1:
		disable_1 = false
		disable_2 = true
	if GlobalVariables.level_count_global == 2:
		disable_1 = true
		disable_2 = false
	if GlobalVariables.level_count_global == 3:
		disable_1 = false
		disable_2 = false
	if GlobalVariables.level_count_global == 4:
		disable_1 = true
		disable_2 = false
	if GlobalVariables.level_count_global >= 5:
		disable_1 = false
		disable_2 = false

func hazard_collision_on() -> void:
	can_collide_parent = true

func hazard_collision_off() -> void:
	can_collide_parent = false

func _on_main_player_missed() -> void:
	hazard_collision_off()




func _drop_hazard() -> void:
	## print("calling _drop_hazard function successful")
	pass

func destroy_all(node: Node = self):
	for child in node.get_children():
		destroy_all(child)  # Recursively handle grandchildren
		child.queue_free()

func inst(pos):
	var instance = hazard_A_scene.instantiate()
	instance.position = pos
	instance.gravity_scale = hazard_A_gravity
	add_child(instance)


func inst_b(pos):
	var instance = hazard_B_scene.instantiate()
	instance.position = pos
	instance.gravity_scale = hazard_B_gravity
	add_child(instance)

func inst_coin(pos):
	var instance = hazard_Coin_scene.instantiate()
	instance.position = pos

	add_child(instance)



func _on_timer_timeout() -> void:
	_difficulty_adjustment()
	
	pass

func _difficulty_adjustment() -> void:
	# O X X
	if disable_2 == true:
		if 12 % modulo_tracker == 3:
			modulo_tracker = 5
			_spawn()
		else:
			modulo_tracker += 2
	
	
	elif disable_1 == true:
		if 12 % modulo_tracker == 3:
			modulo_tracker = 5
			_spawn()
		elif 12 % modulo_tracker == 5:
			modulo_tracker += 2
			_spawn()
		elif 12 % modulo_tracker == 2:
			modulo_tracker += 2
	# O O X
	
	else:
		_spawn()
	
	pass

func _spawn() -> void:
	if ULTIMATE_CAN_SPAWN == true:
		var spawn_mover = randi_range(-1,1)
		
		spawn_number += spawn_mover
		#spawn_number = 2
		
		if spawn_number == 0:
			spawn_number = 1
		
		if spawn_number == 6:
			spawn_number = 5
		
		
		
		if spawn_number == 1:
			if last_spawn_number != 1:
				last_spawn_number = 1
				inst(hazard_one_spawn)
			elif last_spawn_number == 1:
				last_spawn_number = 2
				inst(hazard_two_spawn)
		

		if spawn_number == 2:
			if last_spawn_number != 2:
				if randi_range(0, 100) < 75:
					inst(hazard_two_spawn)
					last_spawn_number = 2
				else:
					inst(hazard_two_spawn)
					#inst_coin(hazard_two_spawn)
					last_spawn_number = 2
			elif last_spawn_number == 2:
				if randi_range(1, 2) == 1:
					inst(hazard_one_spawn)
					last_spawn_number = 1
				else:
					inst(hazard_three_spawn)
					last_spawn_number = 3
		
		if spawn_number == 3:
			if last_spawn_number != 3:
				inst(hazard_three_spawn)
				last_spawn_number = 3
			elif last_spawn_number == 3:
				if randi_range(1, 2) == 1:
					inst(hazard_two_spawn)
					last_spawn_number = 2
				else:
					inst(hazard_four_spawn)
					last_spawn_number = 4
		
		if spawn_number == 4:
			if last_spawn_number != 4:
				if randi_range(0, 100) < 75:
					inst(hazard_four_spawn)
					last_spawn_number = 4
				else:
					inst(hazard_two_spawn)
					#inst_coin(hazard_four_spawn)
					last_spawn_number = 4
			elif last_spawn_number == 4:
				if randi_range(1, 2) == 1:
					inst(hazard_three_spawn)
					last_spawn_number = 3
				else:
					inst(hazard_five_spawn)
					last_spawn_number = 5
		
		
		if spawn_number == 5:
			if last_spawn_number != 5:
				last_spawn_number = 5
				inst(hazard_five_spawn)
			elif last_spawn_number == 5:
				last_spawn_number = 4
				inst(hazard_four_spawn)
	else:
		pass

func _coin_chance() -> int:
	var result = randi_range(0, 1)
	return result

func _on_coin_timer_timeout() -> void:
	if ULTIMATE_CAN_SPAWN == true:
		var coin_flip_chance
		coin_flip_chance = _coin_chance()

		if coin_flip_chance == 0:
			inst_coin(hazard_two_spawn)
		elif coin_flip_chance == 1:
			inst_coin(hazard_four_spawn)
		
		
		if style_number == 5:
			coin_timer.wait_time = randf_range(2.0, 2.5)
			coin_timer.start()
			# print("level 5 timer")
		elif style_number == 4:
			coin_timer.wait_time = randf_range(1.5, 2.0)
			coin_timer.start()
			# print("level 4 timer")
		elif style_number == 3:
			coin_timer.wait_time = randf_range(1.0, 1.5)
			coin_timer.start()
			# print("level 3 timer")
		elif style_number == 2:
			coin_timer.wait_time = randf_range(0.5, 1.0)
			coin_timer.start()
			# print("level 2 timer")
		elif style_number == 1:
			coin_timer.wait_time = randf_range(0.1, 0.3)
			coin_timer.start()
			# print("level 1 timer")
	
	elif ULTIMATE_CAN_SPAWN == false:
		pass

#func _on_hazard_a_body_entered(body: Node) -> void:"linear_damp"
	## print("connection to Hazards succesful for Hazard A")
	##queue_free()
	#pass
#
#func _on_hazard_b_body_entered(body: Node) -> void:
	## print("connection to Hazards succesful for Hazard A")
	##queue_free()
	#pass # Replace with function body.


func _on_hazard_a_hazard_a_miss() -> void:
	miss.emit()
	## print("hazards script hazard A miss working")


func _on_hazard_b_hazard_b_miss() -> void:
	miss.emit()
	## print("hazards script hazard B miss working")

func _on_style_meter_root_rank_s() -> void:
	style_number = 1


func _on_style_meter_root_rank_a() -> void:
	style_number = 2


func _on_style_meter_root_rank_b() -> void:
	style_number = 3


func _on_style_meter_root_rank_c() -> void:
	style_number = 4


func _on_style_meter_root_rank_d() -> void:
	style_number = 5





func _on_player_player_nova_blast() -> void:
	#print(GlobalVariables.round_count_global)
	if GlobalVariables.round_count_global == 4:
		GlobalVariables.level_count_global += 1
		GlobalVariables.round_count_global = 0
		if GlobalVariables.room_number_global < 3:
			GlobalVariables.room_number_global += 1
		elif GlobalVariables.room_number_global == 3:
			GlobalVariables.room_number_global = 1
	GlobalVariables.round_count_global += 1
	#print("the global room number was ", GlobalVariables.room_number_global)
	#await get_tree().create_timer(2.0).timeout
	#print(GlobalVariables.round_count_global)
	


func _on_main_game_over() -> void:
	ULTIMATE_CAN_SPAWN = false


func _on_game_over_retry() -> void:
	ULTIMATE_CAN_SPAWN = true
	GlobalVariables.level_count_global = 1
	GlobalVariables.round_count_global = 1
	coin_timer.start()


func _on_bouncy_coin_shell_coin_grabbed_batonpass_1() -> void:
	coin_grabbed_batonpass_2.emit()
	print("baton pass 2 emitted")
