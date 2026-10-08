extends Sprite2D

@export var back_position := Vector2(1017.0, 741.0)
@export var reset_position := Vector2(732.0, 741.0)
# Called when the node enters the scene tree for  the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_focus_entered() -> void:
	self.position = back_position


func _on_reset_button_focus_entered() -> void:
	self.position = reset_position
