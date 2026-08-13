extends RigidBody2D

@export var spawn_point: Vector2
@export var max_y_velocity: float = 300.0
@onready var main_root_node = get_parent().get_parent()
@onready var hazard_parent = get_parent()
@onready var hazard_a_player := $AnimationPlayer
@onready var can_collide := true
@onready var hazard_sprite := $Sprite2D

signal hazard_a_miss


@onready var bg_number = GlobalVariables.room_number_global
@onready var easy_fall_speed = get_parent().easy_fall_speed
@onready var medium_fall_speed = get_parent().medium_fall_speed
@onready var hard_fall_speed = get_parent().hard_fall_speed

func _ready() -> void:
	
	## get the global variable, roll dice within appt ranges 
	if GlobalVariables.room_number_global == 1:
		var i = randi_range(0, 4)
		#print(i)
		hazard_sprite.set_frame(i)
	if GlobalVariables.room_number_global == 2:
		var i = randi_range(5, 9)
		#print(i)
		hazard_sprite.set_frame(i)
	if GlobalVariables.room_number_global == 3:
		var i = randi_range(10, 14)
		#print(i)
		hazard_sprite.set_frame(i)

	GlobalVariables.hazard_count += 1
	body_entered.connect(_on_body_entered)
	hazard_a_player.play("spin")
	if bg_number == 1:
		max_y_velocity = easy_fall_speed
	elif bg_number == 2:
		max_y_velocity = medium_fall_speed
	elif bg_number == 3:
		max_y_velocity = hard_fall_speed



func _process(delta: float) -> void:
	if hazard_parent.can_collide_parent == true: 
		can_collide = true
		#print("Parent's boolean is true")
	if hazard_parent.can_collide_parent == false:
		can_collide = false
		#print("Parent's boolean is false")


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	pass
	var current_velocity = state.linear_velocity
	if abs(current_velocity.y) > max_y_velocity:
		current_velocity.y = max_y_velocity * sign(current_velocity.y)
		state.linear_velocity = current_velocity

func collision_on() -> void: 
	can_collide = true

func collision_off() -> void:
	can_collide = false

func _on_body_entered(body):
	if body is CharacterBody2D and can_collide == true:
		hazard_a_miss.emit()
		GlobalVariables.hazard_count -= 1
		#print("character")
		queue_free()
		_on_hazard_a_miss()
	
	elif body is CharacterBody2D and can_collide == false:
		GlobalVariables.hazard_count -= 1
		queue_free()

	elif body is StaticBody2D:
		GlobalVariables.hazard_count -= 1
		#print("static")
		queue_free()


func _freeze_hazard_a_test():
	self.freeze = true
	self.global_position = spawn_point

func _on_hazard_a_miss() -> void:
	main_root_node._on_hazard_a_hazard_a_miss()


func _on_hazards_hazards_baton_pass_signal_bg_1() -> void:
	pass
	#print("hazard A received BG signal 1")
	#max_y_velocity = 300.0
func _on_hazards_hazards_baton_pass_signal_bg_2() -> void:
	pass
	#print("hazard A received BG signal 2")
	#max_y_velocity = 350.0
func _on_hazards_hazards_baton_pass_signal_bg_3() -> void:
	pass
	#print("hazard A received BG signal 3")
	#max_y_velocity = 400.0
