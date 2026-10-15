extends Node
	## I know there's some redundancies in here, but for my own sanity, and because tracking these
	## is super minimal on overhead, I'm doing a few of these twice, to avoid breaking anything

var time_bonus_counts := {
	0.0: 0, 1.0: 0, 2.0: 0, 3.0: 0, 4.0: 0, 5.0: 0,
	6.0: 0, 7.0: 0, 8.0: 0, 9.0: 0, 10.0: 0,
}
var total_coins_grabbed := 0
var total_extra_lives_collected := 0
var total_lives_at_end := 3
var total_garbage_bonuses := 0
var total_misses := 0
var total_near_misses := 0

func reset_stat_trackers() -> void:
	print("this WIP global function was called")
	for key in time_bonus_counts:
		time_bonus_counts[key] = 0
	total_coins_grabbed = 0
	total_extra_lives_collected = 0
	total_lives_at_end = 3
	total_garbage_bonuses = 0
	total_misses = 0
	total_near_misses = 0

func test_print_stats() -> void:
	print("time bonus dicts: ", str(time_bonus_counts))
	print("total coins grabbed: ",total_coins_grabbed)
	print("total extra lives collected: ",total_extra_lives_collected)
	print("total lives: ",total_lives_at_end)
	print("total garbage piles destroyed: ",total_garbage_bonuses)
	print("total near misses: ",total_near_misses)
