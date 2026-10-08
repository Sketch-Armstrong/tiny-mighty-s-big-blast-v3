extends Area2D

@onready var spawn_point: Vector2
@onready var main_root_node = get_parent().get_parent().get_parent()
@onready var bouncy_coin_animation_player := $AnimationPlayer
@onready var coin_random_offset = randi_range(-10, 10)

signal coin_grabbed

func _ready() -> void:
	randomize()
	$Sprite2D.offset = Vector2(coin_random_offset, 0)
	#self.global_position = spawn_point
	body_entered.connect(_on_body_entered)
	bouncy_coin_animation_player.play("spin")
	pass

func _on_body_entered(body):
	if body is CharacterBody2D:
		GlobalVariables.end_coin_bonus_total += 1
		GlobalVariables.coin_counter_tracker_global += 1
		main_root_node._on_hazard_coin_score()
		set_collision_mask_value(5, false)
		bouncy_coin_animation_player.play("pickup")
		await bouncy_coin_animation_player.animation_finished
		
		# print("looking for character collision")
		
		#_on_hazard_a_miss()
		queue_free()



#func _on_hazard_a_miss() -> void:
	#main_root_node._on_hazard_coin_score()
