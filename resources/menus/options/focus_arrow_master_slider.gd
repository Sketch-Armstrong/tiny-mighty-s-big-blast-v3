extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_master_slider_focus_entered() -> void:
	self.show()


func _on_master_slider_focus_exited() -> void:
	self.hide()
