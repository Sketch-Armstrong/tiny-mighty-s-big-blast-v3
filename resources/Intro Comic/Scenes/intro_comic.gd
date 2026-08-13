extends Node2D

@onready var IntroPlayer := $IntroComicAnimationPlayer


func _ready() -> void:
	await get_tree().process_frame
	IntroPlayer.play("IntroCutscene")
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		load_scene_test()
		

func load_scene_test() -> void:
	get_tree().change_scene_to_file("res://main_scene.tscn")
