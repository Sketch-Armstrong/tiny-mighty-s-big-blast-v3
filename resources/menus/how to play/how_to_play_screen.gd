extends Node2D

@onready var page_count := 1
@export var max_page_count := 100
signal page_count_changed

var manual_Intro_end := 4
var manual_Table_of_contents := 7
var manual_Basics_Moving := 11
var manual_Basics_Hazards := 15
var manual_Cash := 18
var manual_Style_Meter := 26
var manual_Tricks := 34


@onready var manual_sections := [
	[manual_Intro_end, "Intro"],
	[manual_Table_of_contents, "Table of Contents"],
	[manual_Basics_Moving, "Basics: Moving"],
	[manual_Basics_Hazards, "Basics: Hazards"],
	[manual_Cash, "Cash"],
	[manual_Style_Meter, "Style: Meter"],
	[manual_Tricks, "Style: Tricks"]
]

#@onready var pages_dictionary: Array[Node] = [
	#$Screen1,
	#$Screen2,
	#$Screen3,
	#$Screen4,
	#$Screen5,
	#$Screen6,
	#$Screen7,
	#$Screen8,
	#$Screen9,
	#$Screen10,
	#$Screen11,
	#$Screen12,
	#$Screen13,
	#$Screen14,
	#$Screen15,
	#$Screen16,
	#$Screen17,
	#$Screen18,
	#$Screen19,
	#$Screen20,
	#$Screen21,
	#$Screen22,
	#$Screen23,
	#$Screen24,
	#$Screen25,
	#$Screen26,
	#$Screen27,
	#$Screen28,
	#$Screen29,
	#$Screen30,
	#$Screen31,
	#$Screen32,
	#$Screen33,
	#$Screen34,
	#$Screen35,
	#$Screen36,
	#$Screen37,
	#$Screen38,
	#$Screen39,
	#$Screen40,
	#$Screen41,
	#$Screen42,
	#$Screen43,
	#$Screen44,
	#$Screen45,
	#$Screen46,
	#$Screen47,
	#$Screen48,
	#$Screen49,
	#$Screen50,
	#$Screen51,
	#$Screen52,
	#$Screen53,
	#$Screen54,
	#$Screen55,
	#$Screen56,
	#$Screen57,
	#$Screen58,
	#$Screen59,
	#$Screen60,
	#$Screen61,
	#$Screen62,
	#$Screen63,
	#$Screen64,
	#$Screen65,
	#$Screen66,
	#$Screen67,
	#$Screen68,
	#$Screen69,
	#$Screen70,
	#$Screen71,
	#$Screen72,
	#$Screen73,
	#$Screen74,
	#$Screen75,
	#$Screen76,
	#$Screen77,
	#$Screen78,
	#$Screen79,
	#$Screen80,
	#$Screen81,
	#$Screen82,
	#$Screen83,
	#$Screen84,
	#$Screen85,
	#$Screen86,
	#$Screen87,
	#$Screen88,
	#$Screen89,
	#$Screen90,
	#$Screen91,
	#$Screen92,
	#$Screen93,
	#$Screen94,
	#$Screen95,
	#$Screen96,
	#$Screen97,
	#$Screen98,
	#$Screen99,
	#$Screen100,
#]
	#

	## the original way I was going to do it

var pages_dictionary: Array[Node] = []


func _ready() -> void:
	#var i := 1
	#while true:
		#var screen := get_node_or_null("Screen%d" % i)
		#if screen == null:
			#break
		#pages_dictionary.append(screen)
		#i += 1
		## then I looked into doing a while loop
	for node in get_tree().get_nodes_in_group("manual_page"):
		pages_dictionary.append(node)
			## eventually I found that doing just putting it all in a group worked best
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
	if page_count < max_page_count:
		page_count += 1
		_check_page_count()
	else: 
		return

func _check_page_count() -> void:
	$Node/PageNumberLabel.text = str(page_count)
	_update_section_label()
	for i in pages_dictionary.size():
		pages_dictionary[i].visible = (i == page_count - 1)
		# the (i == page_count -1) is because it's easier for me to track pages if I 
		# don't start on page 0
	

func _update_section_label() -> void:
	for section in manual_sections:
		if page_count <= section[0]:
			$Node/Section.text = section[1] + " "
			break


func _on_h_slider_value_changed(value: float) -> void:
	page_count = $HSlider.value
	_check_page_count()
	pass


func _on_h_slider_changed() -> void:
	#page_count = $HSlider.value
	pass
