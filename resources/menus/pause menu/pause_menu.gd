extends Control

@onready var test_sound := $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#visible = false
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		_pause()

func _pause() -> void:
	if get_tree().paused:
		visible = false
		test_sound.play()
		get_tree().paused = false
	else:
		visible = true
		test_sound.play()
		get_tree().paused = true

func _on_button_pressed() -> void:
	_pause()

func _on_options_button_pressed() -> void:
	#print("options button pressed. Add options later please")
	pass


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://resources/menus/main menu/main_menu.tscn")
