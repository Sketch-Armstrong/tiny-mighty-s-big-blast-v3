extends Node2D
@onready var bomb_player := $BombPlayer
@onready var miss_sprite := $MissSprite

func _ready() -> void:
	#bomb_player.play("fade out")
	pass

func bomb_blow() -> void:
	bomb_player.play("bomb_blow")
	


func bomb_reset() -> void:
	bomb_player.play("return_visible")
