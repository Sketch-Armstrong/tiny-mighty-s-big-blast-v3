extends RigidBody2D

@export var spawn_point: Vector2
@export var max_y_velocity: float = 25.0
signal hazard_a_miss
@onready var main_root_node = get_parent().get_parent()



func _ready() -> void:
	queue_free()
	body_entered.connect(_on_body_entered)
	set_gravity_scale(0.2)
	await get_tree().create_timer(1.0).timeout
	set_gravity_scale(10)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	pass
	var current_velocity = state.linear_velocity
	if abs(current_velocity.y) > max_y_velocity:
		current_velocity.y = max_y_velocity * sign(current_velocity.y)
		state.linear_velocity = current_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	if body is CharacterBody2D:
		## print("SCORE")
		#_on_hazard_a_miss()
		#queue_free()
		pass
	if body is StaticBody2D:
		# print("clear")

		#self.sleeping = true
		#await get_tree().create_timer(1.0).timeout
		#self.sleeping = false
		queue_free()
	pass

func _freeze_hazard_a_test():
	self.freeze = true
	self.global_position = spawn_point


func _on_hazard_a_miss() -> void:
	main_root_node._on_hazard_coin_score()

func _separate_queue_free_func() -> void:
	queue_free()
