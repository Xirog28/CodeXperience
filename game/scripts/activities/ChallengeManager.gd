extends Node


var challenges = [
	preload("res://scripts/activities/reto_variables.tres"),
	preload("res://scripts/activities/reto_condicional.tres"),
	preload("res://scripts/activities/reto_ciclo.tres")
]


func get_challenge_by_difficulty(difficulty: int) -> ProgrammingChallenge:
	for challenge in challenges:
		if challenge.difficulty == difficulty:
			return challenge

	return challenges[0]


func get_challenge_by_concept(concept: String) -> ProgrammingChallenge:
	for challenge in challenges:
		if challenge.concept == concept:
			return challenge

	return null


func get_adaptive_challenge(
	recommended_difficulty: int,
	weakest_concept: String
) -> ProgrammingChallenge:

	# Primero intenta encontrar un reto que coincida
	# con el concepto débil y la dificultad recomendada.
	for challenge in challenges:
		if (
			challenge.concept == weakest_concept
			and challenge.difficulty == recommended_difficulty
		):
			return challenge

	# Si no existe esa combinación,
	# busca cualquier reto del concepto débil.
	for challenge in challenges:
		if challenge.concept == weakest_concept:
			return challenge

	# Si tampoco existe, utiliza la dificultad recomendada.
	return get_challenge_by_difficulty(recommended_difficulty)
