extends Node2D

@onready var ChildAnimationPlayer := $ChildAnimationPlayer

func _ready() -> void:
	animate_orbit()

func animate_orbit () -> void:
	ChildAnimationPlayer.play("orbit")
