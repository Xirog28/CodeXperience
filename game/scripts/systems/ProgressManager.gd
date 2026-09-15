extends Node

var level: int = 1
var points: int = 0
var completed_challenges: int = 0
var attempts: int = 0
var errors: int = 0

var challenge_start_time: int = 0
var total_time: float = 0.0

# Historial de rendimiento del jugador
var performance_history: Array[Dictionary] = []


func start_challenge():
	challenge_start_time = Time.get_ticks_msec()


func finish_challenge() -> float:
	if challenge_start_time == 0:
		return 0.0

	var elapsed = float(Time.get_ticks_msec() - challenge_start_time) / 1000.0
	total_time += elapsed
	challenge_start_time = 0

	return elapsed


func register_attempt():
	attempts += 1


func register_error():
	errors += 1


func complete_challenge(points_earned: int):
	completed_challenges += 1
	points += points_earned


func register_performance(
	challenge_name: String,
	concept: String,
	challenge_time: float,
	correct: bool
):
	var result = {
		"challenge": challenge_name,
		"concept": concept,
		"time": challenge_time,
		"correct": correct
	}

	performance_history.append(result)
