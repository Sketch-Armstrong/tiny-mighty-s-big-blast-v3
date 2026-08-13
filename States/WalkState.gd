extends State
class_name WalkState

var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("tiny_move_right"):
		player.velocity.x = min(player.velocity.x + acceleration * delta, max_speed * delta)
	elif Input.is_action_pressed("tiny_move_left"):
		player.velocity.x = max(player.velocity.x - acceleration * delta, -max_speed * delta)
	else:
		get_parent().change_state("idle")
