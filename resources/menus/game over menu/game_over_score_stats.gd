extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	## time_left is inversely proportional to time bonus, it's YOUR job to spell it out in the
	## stats screen, and make it clear [pointing at self]

	$Control/VBoxContainer/SecondsLeft10/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[10.0])
	$Control/VBoxContainer/SecondsLeft9/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[9.0])
	$Control/VBoxContainer/SecondsLeft8/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[8.0])
	$Control/VBoxContainer/SecondsLeft7/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[7.0])
	$Control/VBoxContainer/SecondsLeft6/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[6.0])
	$Control/VBoxContainer/SecondsLeft5/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[5.0])
	$Control/VBoxContainer/SecondsLeft4/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[4.0])
	$Control/VBoxContainer/SecondsLeft3/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[3.0])
	$Control/VBoxContainer/SecondsLeft2/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[2.0])
	$Control/VBoxContainer/SecondsLeft1/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[1.0])
	$Control/VBoxContainer/SecondsLeft0/RichTextLabel2.text = str(GlobalStatTracking.time_bonus_counts[0.0])
	$Control/VBoxContainer/TotalCoinsCollected/RichTextLabel2.text = str(GlobalStatTracking.total_coins_grabbed)
	$Control/VBoxContainer/ExtraLivesCollected/RichTextLabel2.text = str(GlobalStatTracking.total_extra_lives_collected)
	$Control/VBoxContainer/LivesEndCount/RichTextLabel2.text = str(GlobalStatTracking.total_lives_at_end)
	$Control/VBoxContainer/TotalNearMisses/RichTextLabel2.text = str(GlobalStatTracking.total_near_misses)
	$Control/VBoxContainer/TotalMisses/RichTextLabel2.text = str(GlobalStatTracking.total_misses)
	$Control/VBoxContainer/TotalGarbageBonuses/RichTextLabel2.text = str(GlobalStatTracking.total_garbage_bonuses)
	
	
	
	
	
	
