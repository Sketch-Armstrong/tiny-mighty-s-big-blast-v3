extends State
class_name IdleState

@onready var player = get_parent().get_parent()
@onready var dash_animation_test = player.dash_animation
@onready var idle_animation = player.idle_animation
@onready var idle_sprites = player.idle_sprites
@onready var icon = player.icon
@onready var main_scene = player.main_scene



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	idle_animation.play("idle")
	
