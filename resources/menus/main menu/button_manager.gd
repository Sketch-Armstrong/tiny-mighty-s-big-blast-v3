extends VBoxContainer

@onready var arrow_icon = $FocusArrow
@export var offset = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	#if GlobalFocusBooleans.main_menu_focus == true:
		#$".".grab_focus()
	pass


func _on_scores_focus_entered() -> void:
	arrow_icon.visible = true
	arrow_icon.position = $Scores.position + offset


func _on_start_focus_entered() -> void:
	arrow_icon.visible = true
	arrow_icon.position = $Start.position + offset
	


func _on_options_focus_entered() -> void:
	arrow_icon.visible = true
	arrow_icon.position = $Options.position + offset


func _on_quit_focus_entered() -> void:
	arrow_icon.visible = true
	arrow_icon.position = $Quit.position + offset


func _on_legal_focus_entered() -> void:
	arrow_icon.visible = true
	arrow_icon.position = $Legal.position + offset
