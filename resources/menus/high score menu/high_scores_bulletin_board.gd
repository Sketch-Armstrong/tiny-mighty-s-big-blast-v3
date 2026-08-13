extends Node2D

@onready var SmallSallyPh := $Small/SallyPhoto
@onready var SmallSallyNo := $Small/SallyNote
@onready var SmallPapi := $Small/Papi
@onready var SmallMax := $Small/Max
@onready var SmallClaire := $Small/Claire
@onready var SmallGrande := $Small/ElGrande

@onready var BigSallyPh := $Big/SallyPhoto
@onready var BigSallyNo := $Big/SallyNote
@onready var BigPapi := $Big/Papi
@onready var BigMax := $Big/Max
@onready var BigClaire := $Big/Claire
@onready var BigGrande := $Big/ElGrande

@onready var BulletinClear := $Toggler/Control/ClearSignalerButton
@onready var Toggle1 := $Toggler/Control/CheckButton
@onready var Toggle2 := $Toggler/Control/CheckButton2
@onready var Toggle3 := $Toggler/Control/CheckButton3
@onready var Toggle4 := $Toggler/Control/CheckButton4
@onready var Toggle5 := $Toggler/Control/CheckButton5
@onready var Toggle6 := $Toggler/Control/CheckButton6
@onready var BulletinBack := $Toggler/Control/BackSignalerButton

signal BulletinClearPressed
signal BulletinClearFocused

signal BulletinBackPressed
signal BulletinBackFocused


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	#Toggle1.grab_focus()
	#$Small/ElGrande/Button.grab_focus()
	#await get_tree().create_timer(2).timeout
	##$Small/SallyPhoto/Button.grab_focus()
	#if $Small/ElGrande/Button.has_focus():
		#$Small/ElGrande/Button.release_focus()
	$Big/SallyPhoto.hide()
	$Big/SallyNote.hide()
	$Big/Papi.hide()
	$Big/Max.hide()
	$Big/Claire.hide()
	$Big/ElGrande.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
	
	if BulletinClear.has_focus():
		BulletinClearFocused.emit()
		#print("bulletin clear focused")
	if BulletinBack.has_focus():
		BulletinBackFocused.emit()
		#print("bulletin back focused")
	
	if Toggle1.has_focus() == false:
		Toggle1.button_pressed = false
		SmallSallyPh.set_frame(20)
	if Toggle2.has_focus() == false:
		Toggle2.button_pressed = false
		SmallSallyNo.set_frame(16)
	if Toggle3.has_focus() == false:
		Toggle3.button_pressed = false
		SmallPapi.set_frame(12)
	if Toggle4.has_focus() == false:
		Toggle4.button_pressed = false
		SmallMax.set_frame(8)
	if Toggle5.has_focus() == false:
		Toggle5.button_pressed = false
		SmallClaire.set_frame(4)
	if Toggle6.has_focus() == false:
		Toggle6.button_pressed = false
		SmallGrande.set_frame(0)
	
	if Toggle1.has_focus() == true:
		SmallSallyPh.set_frame(21)
	if Toggle2.has_focus() == true:
		SmallSallyNo.set_frame(17)
	if Toggle3.has_focus() == true:
		SmallPapi.set_frame(13)
	if Toggle4.has_focus() == true:
		SmallMax.set_frame(9)
	if Toggle5.has_focus() == true:
		SmallClaire.set_frame(5)
	if Toggle6.has_focus() == true:
		SmallGrande.set_frame(1)


	## the order is 
	## Sally photo
	## Sally note
	## Papi
	## Max
	## Claire
	## Grande

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		SmallSallyPh.show()
		BigSallyPh.hide()
	if toggled_on == true:
		SmallSallyPh.hide()
		BigSallyPh.show()


func _on_check_button_2_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		SmallSallyNo.show()
		BigSallyNo.hide()
	if toggled_on == true:
		SmallSallyNo.hide()
		BigSallyNo.show()


func _on_check_button_3_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		SmallPapi.show()
		BigPapi.hide()
	if toggled_on == true:
		SmallPapi.hide()
		BigPapi.show()


func _on_check_button_4_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		SmallMax.show()
		BigMax.hide()
	if toggled_on == true:
		SmallMax.hide()
		BigMax.show()

func _on_check_button_5_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		SmallClaire.show()
		BigClaire.hide()
	if toggled_on == true:
		SmallClaire.hide()
		BigClaire.show()

func _on_check_button_6_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		SmallGrande.show()
		BigGrande.hide()
	if toggled_on == true:
		SmallGrande.hide()
		BigGrande.show()


func _on_clear_signaler_button_pressed() -> void:
	pass # Replace with function body.
	BulletinClearPressed.emit()

func _on_back_signaler_button_pressed() -> void:
	pass # Replace with function body.
	BulletinBackPressed.emit()
