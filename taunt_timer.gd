extends Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_brute_force_taunt_pressed() -> void:
	self.paused = false


func _on_player_brute_force_taunt_release() -> void:
	self.paused = true
