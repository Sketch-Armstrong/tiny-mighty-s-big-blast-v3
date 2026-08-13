	if player_animation_player.current_animation == "Dash" or "Dash_Flip" and player_animation_player.is_playing():
		if near_miss_collision.is_colliding() == true:
			print("near miss ray collided")
			near_miss_collision.enabled = false
			await player_animation_player.animation_finished
			near_miss_boolean = true
			near_miss_collision.enabled = true
			
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
