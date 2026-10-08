extends RichTextLabel

@export var scroll_speed := 400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Input.get_axis("ui_up", "ui_down")
	if direction != 0.0:
		var scrollbar := get_v_scroll_bar()
		scrollbar.value += direction * scroll_speed * delta
