extends Node

var level: int = 1
var points: int = 0
var completed_challenges: int = 0
var attempts: int = 0
var errors: int = 0
func register_attempt():
	attempts += 1


func register_error():
	errors += 1


func complete_challenge(points_earned: int):
	completed_challenges += 1
	points += points_earned
