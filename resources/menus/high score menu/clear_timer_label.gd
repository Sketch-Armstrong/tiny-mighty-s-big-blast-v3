extends RichTextLabel
@onready var clear_timer: int

@onready var clearing_bool := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if clearing_bool == true:
		set_time()
	else:
		self.text = str("hold button to clear")


func set_time() -> void: 
	clear_timer = round($"../../Control/ClearTimer".time_left)
	self.text = str(clear_timer)


func _on_clear_signaler_button_button_down() -> void:
	clearing_bool = true


func _on_clear_signaler_button_button_up() -> void:
	clearing_bool = false
