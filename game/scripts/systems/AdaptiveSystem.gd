extends Node

var difficulty: int = 1
func calculate_difficulty(errors: int, attempts: int) -> int:
	if attempts == 0:
		return difficulty

	var error_rate = float(errors) / float(attempts)

	if error_rate >= 0.6:
		difficulty = 1
	elif error_rate >= 0.3:
		difficulty = 2
	else:
		difficulty = 3

	return difficulty
