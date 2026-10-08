extends Sprite2D
@export var BF_scores_position: Vector2 = Vector2(100, 200)
@export var BF_start_position: Vector2 = Vector2(100, 300)
@export var BF_options_position: Vector2 = Vector2(100, 400)
@export var BF_quit_position: Vector2 = Vector2(100, 500)
@export var BF_legal_position: Vector2 = Vector2(100, 600)
@export var BF_h2p_position: Vector2 = Vector2(-88.0, 560.0)
		## I genuinely don't remember why I named this "BF_(information)"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_scores_focus_entered() -> void:
	self.position = BF_scores_position


func _on_start_focus_entered() -> void:
	self.position = BF_start_position


func _on_options_focus_entered() -> void:
	self.position = BF_options_position


func _on_quit_focus_entered() -> void:
	self.position = BF_quit_position


func _on_legal_focus_entered() -> void:
	self.position = BF_legal_position


func _on_how_to_play_button_focus_entered() -> void:
	self.position = BF_h2p_position
	self.flip_h = true


func _on_how_to_play_button_focus_exited() -> void:
	self.flip_h = false
