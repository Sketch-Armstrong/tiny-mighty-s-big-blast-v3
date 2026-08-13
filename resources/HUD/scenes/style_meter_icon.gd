extends Node2D

@onready var icon_player = $StyleIconAnimationPlayer
@onready var icon_sprite = $IconSprite
@onready var great_grandparent_style_bar = get_parent().get_parent().get_parent().get_node("ProgressBar")
#@onready var style_bar_value = great_grandparent_style_bar.value

func _ready() -> void:
	icon_player.play("animate")
	#print(style_bar_value)
	
##this IS working, it's just not going to return anything if ran standalone because there is no grandparent node to call

func _process(delta: float) -> void:
	var style_bar_value = great_grandparent_style_bar.value
	icon_sprite.offset.x = -100 + (style_bar_value * 2.1)
