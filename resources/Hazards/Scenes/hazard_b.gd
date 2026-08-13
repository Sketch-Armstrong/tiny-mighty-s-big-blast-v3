extends RigidBody2D

@export var spawn_point: Vector2
@export var max_y_velocity: float = 300.0
@onready var main_root_node = get_parent().get_parent()
@onready var hazard_b_player := $AnimationPlayer

signal hazard_b_miss

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	hazard_b_player.play("spin")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	pass
	var current_velocity = state.linear_velocity
	if abs(current_velocity.y) > max_y_velocity:
		current_velocity.y = max_y_velocity * sign(current_velocity.y)
		state.linear_velocity = current_velocity

func _on_body_entered(body):
	if body is CharacterBody2D:
		queue_free()
		#_on_hazard_b_miss()
	elif body is StaticBody2D:
		queue_free()
	pass

func _freeze_hazard_a_test():
	self.freeze = true
	self.global_position = spawn_point

func _on_hazard_b_miss() -> void:
	main_root_node._on_hazard_b_hazard_b_miss()


func _on_hazards_hazards_baton_pass_signal_bg_2() -> void:
	pass # Replace with function body.
