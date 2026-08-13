extends CanvasLayer

@onready var ChainPlayer := $Background1/ChainAnimationPlayer
@onready var SconcePlayer := $Background1/SconceAnimationPlayer
@onready var JunkPlayer := $JunkPile/JunkAnimationPlayer
@onready var HigherJunkPlayer := $JunkPlayer2
@onready var BarrelPlayer := $Background2/BarrelsPlayer

@onready var BGAPlayer := $Background1/BGAssetPlayer

@onready var shake1_animation = BGAPlayer.get_animation("shake")

@onready var BG1 := $Background1
@onready var BG1_temp_more := $Background1/BackgroundAssets
@onready var BG2 := $Background2
@onready var BG3 := $Background3
	#!= Baldur's Gate

@onready var level_change_sprite := $LevelTransitionRootNode/LevelChange
@onready var change_player := $LevelTransitionRootNode/LevelChangePlayer


@onready var level_progress := GlobalVariables.level_count_global
@export var level_transition_timer := 0.0

@onready var change_tracker = 0

func _ready() -> void:
	SconcePlayer.play("sconce_billow")
	#shake1_animation.track_set_enabled(0, false)
	#shake1_animation.track_set_enabled(1, false)
	#shake1_animation.track_set_enabled(2, false)
	#shake1_animation.track_set_enabled(3, false)
	#shake1_animation.track_set_enabled(4, false)
	#shake1_animation.track_set_enabled(5, false)
	#shake1_animation.track_set_enabled(6, false)
	#shake1_animation.track_set_enabled(7, false)

func _process(delta: float) -> void:
	pass



func _chain_rattle() -> void:
	await get_tree().create_timer(0.7).timeout
	#JunkPlayer.play("Shake")
	ChainPlayer.play("chains_rattle")
	SconcePlayer.play("sconce_blown")
	await SconcePlayer.animation_finished
	SconcePlayer.play("sconce_billow")


func _on_player_player_nova_blast() -> void:
	_room_shake()
	_set_bg_room()




func _room_shake() -> void:
	if GlobalVariables.room_number_global == 1:
		_chain_rattle()
		await get_tree().create_timer(0.7).timeout
		if change_tracker == 1:
			JunkPlayer.play("Shake")
		if change_tracker == 2:
			await get_tree().process_frame
			JunkPlayer.play("Shake_2")
			JunkPlayer.advance(0.0)
		if change_tracker == 3:
			JunkPlayer.play("Shake_3")
		BGAPlayer.play("shake")
		HigherJunkPlayer.play("junk_shake_external")

	elif GlobalVariables.room_number_global == 2:
		_chain_rattle()
		await get_tree().create_timer(0.7).timeout
		if change_tracker == 1:
			JunkPlayer.play("Shake")
		if change_tracker == 2:
			await get_tree().process_frame
			JunkPlayer.play("Shake_2")
			JunkPlayer.advance(0.0)
		if change_tracker == 3:
			JunkPlayer.play("Shake_3")
		BarrelPlayer.play("barrels_bounce")
		HigherJunkPlayer.play("junk_shake_external")
		BGAPlayer.play("shake_2")

	elif GlobalVariables.room_number_global == 3:
		await get_tree().create_timer(0.7).timeout
		if change_tracker == 1:
			JunkPlayer.play("Shake")
		if change_tracker == 2:
			await get_tree().process_frame
			JunkPlayer.play("Shake_2")
			JunkPlayer.advance(0.0)
		if change_tracker == 3:
			JunkPlayer.play("Shake_3")
		HigherJunkPlayer.play("junk_shake_external")
		BGAPlayer.play("shake_3")
		

func _change_level_animation() -> void:
	change_player.play("change_levels")

func global_tiny_visible() -> void:
	GlobalVariables.tiny_visible = true
	print(GlobalVariables.tiny_visible)

func global_tiny_visible_false() -> void:
	GlobalVariables.tiny_visible = false
	print(GlobalVariables.tiny_visible)

func _set_bg_room() -> void:
	if change_tracker == -1:
		BG1.show()
		BG1_temp_more.show()
		BG2.hide()
		BG3.hide()
	
	change_tracker += 1
	
	if GlobalVariables.room_number_global == 1:
		if change_tracker == 4:
			change_tracker = 0
			await get_tree().create_timer(0.7).timeout
			BGAPlayer.play("shake_3")
			JunkPlayer.play("Shake_4")
			await BGAPlayer.animation_finished
			_change_level_animation()
			await get_tree().create_timer(0.2).timeout
			JunkPlayer.play("RESET")
			BG1.show()
			BG1_temp_more.show()
			BG2.hide()
			BG3.hide()
	
	if GlobalVariables.room_number_global == 2:
		if change_tracker == 4:
			change_tracker = 0
			await get_tree().create_timer(0.7).timeout
			BGAPlayer.play("shake")
			JunkPlayer.play("Shake_4")
			await BGAPlayer.animation_finished
			_change_level_animation()
			await get_tree().create_timer(0.2).timeout
			JunkPlayer.play("RESET")
			BG1.hide()
			BG1_temp_more.hide()
			BG2.show()
			BG3.hide()
	
	if GlobalVariables.room_number_global == 3:
		if change_tracker == 4:
			change_tracker = 0
			await get_tree().create_timer(0.7).timeout
			BGAPlayer.play("shake_2")
			JunkPlayer.play("Shake_4")
			BarrelPlayer.play("barrels_bounce")
			await BGAPlayer.animation_finished
			_change_level_animation()
			await get_tree().create_timer(0.2).timeout
			JunkPlayer.play("RESET")
			BG1.hide()
			BG1_temp_more.hide()
			BG2.hide()
			BG3.show()




func _on_game_over_retry() -> void:
	GlobalVariables.room_number_global = 1
	change_tracker = -1
	#print("change tracker value was: ", change_tracker)
	print("game over retry signal received")
	_set_bg_room()
