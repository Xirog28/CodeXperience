extends Node


func _ready():
	var challenge: ProgrammingChallenge = preload("res://scripts/activities/reto_variables.tres")
	var validator = ChallengeValidator.new()

	var correct = validator.validate(challenge, "var score = 100")
	var incorrect = validator.validate(challenge, "var score = 50")

	print("Respuesta correcta: ", correct)
	print("Respuesta incorrecta: ", incorrect)
