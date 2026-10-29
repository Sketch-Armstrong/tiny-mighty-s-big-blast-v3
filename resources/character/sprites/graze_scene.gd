extends Node2D
@onready var graze_player := $GrazeAnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	#$AnimationPlayer.play("GRAZE")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_graze() -> void:
	graze_player.play("GRAZE")
	if graze_player.is_playing():
		graze_player.stop()
		graze_player.play("GRAZE")
