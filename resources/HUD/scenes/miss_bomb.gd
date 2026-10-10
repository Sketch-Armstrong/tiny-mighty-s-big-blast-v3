extends Node2D
@onready var bomb_player := $BombPlayer
@onready var miss_sprite := $MissSprite

func _ready() -> void:
	#bomb_player.play("fade out")
	pass

func bomb_blow() -> void:
	bomb_player.play("bomb_blow")

func bomb_shimmer() -> void:
	bomb_player.play("shimmer")

func change_to_gem() -> void:
	bomb_player.play("change")
	await bomb_player.animation_finished
	bomb_player.play("shimmer_gem")

func gem_shimmer() -> void:
	bomb_player.play("shimmer_gem")

func bomb_reset() -> void:
	bomb_player.play("RESET")
