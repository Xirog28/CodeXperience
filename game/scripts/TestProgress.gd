extends Node


func _ready():
	var challenge: ProgrammingChallenge = preload("res://scripts/activities/reto_variables.tres")
	var validator = ChallengeValidator.new()

	var user_code = "var score = 100"

	ProgressManager.register_attempt()

	var correct = validator.validate(challenge, user_code)

	if correct:
		ProgressManager.complete_challenge(10)
	else:
		ProgressManager.register_error()

	print("Respuesta correcta: ", correct)
	print("Intentos: ", ProgressManager.attempts)
	print("Errores: ", ProgressManager.errors)
	print("Retos completados: ", ProgressManager.completed_challenges)
	print("Puntos: ", ProgressManager.points)
