extends Node


var difficulty: int = 1


# =========================================================
# CALCULAR DIFICULTAD
# =========================================================

func calculate_difficulty(
	errors: int,
	attempts: int,
	challenge_time: float
) -> int:

	if attempts == 0:
		return difficulty

	var error_rate = float(errors) / float(attempts)

	# Muchos errores → dificultad fácil
	if error_rate >= 0.6:
		difficulty = 1

	# Algunos errores o demasiado tiempo → dificultad intermedia
	elif error_rate >= 0.3 or challenge_time > 120.0:
		difficulty = 2

	# Pocos errores y buen tiempo → dificultad difícil
	else:
		difficulty = 3

	return difficulty


# =========================================================
# ANALIZAR RENDIMIENTO
# =========================================================

func analyze_performance(
	errors: int,
	attempts: int,
	challenge_time: float
) -> Dictionary:

	if attempts == 0:
		return {
			"attempts": 0,
			"errors": 0,
			"error_rate": 0.0,
			"challenge_time": challenge_time,
			"performance": "sin datos",
			"recommended_difficulty": difficulty
		}

	var error_rate = float(errors) / float(attempts)

	var performance = "medio"

	if error_rate >= 0.6:
		performance = "bajo"

	elif error_rate < 0.3 and challenge_time <= 120.0:
		performance = "alto"

	var recommended_difficulty = calculate_difficulty(
		errors,
		attempts,
		challenge_time
	)

	return {
		"attempts": attempts,
		"errors": errors,
		"error_rate": error_rate,
		"challenge_time": challenge_time,
		"performance": performance,
		"recommended_difficulty": recommended_difficulty
	}


# =========================================================
# ANALIZAR HISTORIAL
# =========================================================

func analyze_history(history: Array[Dictionary]) -> Dictionary:

	if history.is_empty():
		return {
			"total_challenges": 0,
			"correct_challenges": 0,
			"incorrect_challenges": 0,
			"success_rate": 0.0
		}

	var correct_challenges = 0

	for result in history:
		if result["correct"]:
			correct_challenges += 1

	var total_challenges = history.size()
	var incorrect_challenges = total_challenges - correct_challenges
	var success_rate = float(correct_challenges) / float(total_challenges)

	return {
		"total_challenges": total_challenges,
		"correct_challenges": correct_challenges,
		"incorrect_challenges": incorrect_challenges,
		"success_rate": success_rate
	}


# =========================================================
# ANALIZAR RENDIMIENTO POR CONCEPTO
# =========================================================

func analyze_concepts(history: Array[Dictionary]) -> Dictionary:

	var concepts = {}

	for result in history:

		var concept = result["concept"]

		if not concepts.has(concept):
			concepts[concept] = {
				"total": 0,
				"correct": 0,
				"incorrect": 0,
				"success_rate": 0.0
			}

		concepts[concept]["total"] += 1

		if result["correct"]:
			concepts[concept]["correct"] += 1
		else:
			concepts[concept]["incorrect"] += 1

	for concept in concepts:

		var total = concepts[concept]["total"]
		var correct = concepts[concept]["correct"]

		concepts[concept]["success_rate"] = float(correct) / float(total)

	return concepts


# =========================================================
# DETECTAR CONCEPTO MÁS DÉBIL
# =========================================================

func get_weakest_concept(
	concept_analysis: Dictionary
) -> String:

	if concept_analysis.is_empty():
		return ""

	var weakest_concept = ""
	var lowest_success_rate = 1.0

	for concept in concept_analysis:

		var success_rate = concept_analysis[concept]["success_rate"]

		if success_rate < lowest_success_rate:

			lowest_success_rate = success_rate
			weakest_concept = concept

	return weakest_concept


# =========================================================
# GENERAR RECOMENDACIÓN ADAPTATIVA
# =========================================================

func generate_recommendation(
	performance: String,
	recommended_difficulty: int,
	weakest_concept: String
) -> Dictionary:

	var action = ""
	var message = ""

	if performance == "bajo":

		action = "reforzar"

		message = (
			"El jugador presenta dificultades en el concepto "
			+ weakest_concept
			+ ". Se recomienda reforzar este concepto "
			+ "antes de aumentar la dificultad."
		)

	elif performance == "medio":

		action = "practicar"

		message = (
			"El jugador muestra un rendimiento intermedio. "
			+ "Se recomienda practicar el concepto "
			+ weakest_concept
			+ " con una dificultad moderada."
		)

	elif performance == "alto":

		action = "avanzar"

		message = (
			"El jugador presenta un buen rendimiento. "
			+ "Se recomienda avanzar progresivamente "
			+ "hacia retos de mayor dificultad."
		)

	else:

		action = "iniciar"

		message = (
			"No hay suficientes datos para evaluar "
			+ "el rendimiento del jugador."
		)

	return {
		"performance": performance,
		"weakest_concept": weakest_concept,
		"recommended_difficulty": recommended_difficulty,
		"action": action,
		"message": message
	}
