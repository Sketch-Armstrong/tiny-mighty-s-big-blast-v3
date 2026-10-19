extends Node2D

@onready var page_count := 1
@onready var screen1 = $Screen1
@onready var screen2 = $Screen2
@onready var screen3 = $Screen3



func _ready() -> void:
	_check_page_count()


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_button_previous_pressed() -> void:
	if page_count > 1:
		page_count -= 1
		_check_page_count()
	else: 
		return


func _on_button_next_pressed() -> void:
	if page_count < 3:
		page_count += 1
		_check_page_count()
	else: 
		return

func _check_page_count() -> void:
	match page_count:
		1:
			print("testing printing matching")
			screen1.show()
			screen2.hide()
			screen3.hide()
			
		2:
			print("testing printing matching 2")
			screen1.hide()
			screen2.show()
			screen3.hide()
		3:
			print("testing printing matching 3")
			screen1.hide()
			screen2.hide()
			screen3.show()
