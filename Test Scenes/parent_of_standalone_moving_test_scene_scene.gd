extends Node2D

@onready var test_child_scene = preload("res://Test Scenes/standalone position animation test node.tscn")
@onready var parent_animation_player := $ParentAnimationPlayer
@onready var parent_node := $"."

func ready() -> void:
	attempt_to_force_orbit_move()
	#test_child_scene.play("orbit")
	
	#the thought you had was something involving creating a function in the child node, and then calling 

func attempt_to_force_orbit_move() -> void:
	parent_animation_player.play("move_right_while_orbit_test")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("tiny_move_right"):
		#parent_node.global_position = Vector2(150, 500)
		attempt_to_force_orbit_move()
