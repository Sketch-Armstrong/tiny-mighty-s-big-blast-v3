extends Node

## ====== stat tracking block ======
	## I know there's some redundancies in here, but for my own sanity, and because tracking these
	## is super minimal on overhead, I'm doing it twice to make it easier to add these in

var time_bonus_counts := {
	0.0: 0, 1.0: 0, 2.0: 0, 3.0: 0, 4.0: 0, 5.0: 0,
	6.0: 0, 7.0: 0, 8.0: 0, 9.0: 0, 10.0: 0,
}


var total_coins_grabbed := 0
var total_extra_lives_at_end := 0
var total_garbage_bonuses := 0
var total_near_miss := 0
## ====== stat tracking block ======

func reset_stat_trackers() -> void:
	print("this WIP global function was called")
	## when you put in the individual stat trackers above here, put resetting them to zero in here
	for key in time_bonus_counts:
		time_bonus_counts[key] = 0
	total_coins_grabbed = 0
	total_extra_lives_at_end = 0
	total_garbage_bonuses = 0
	total_near_miss = 0
