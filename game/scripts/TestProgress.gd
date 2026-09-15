extends Node


func _ready():
	var challenge: ProgrammingChallenge = preload("res://scripts/activities/reto_variables.tres")
	var validator = ChallengeValidator.new()
	var challenge_manager = preload("res://scripts/activities/ChallengeManager.gd").new()

	var user_code = "var score = 50"


	# ==========================================
	# INICIAR RETO
	# ==========================================

	ProgressManager.start_challenge()

	ProgressManager.register_attempt()

	var correct = validator.validate(challenge, user_code)

	if correct:
		ProgressManager.complete_challenge(10)
	else:
		ProgressManager.register_error()

	var challenge_time = ProgressManager.finish_challenge()


	# ==========================================
	# REGISTRAR RESULTADO
	# ==========================================

	ProgressManager.register_performance(
		challenge.challenge_name,
		challenge.concept,
		challenge_time,
		correct
	)


	# ==========================================
	# RESULTADO DEL RETO
	# ==========================================

	print("Respuesta correcta: ", correct)
	print("Intentos: ", ProgressManager.attempts)
	print("Errores: ", ProgressManager.errors)
	print("Retos completados: ", ProgressManager.completed_challenges)
	print("Puntos: ", ProgressManager.points)
	print("Tiempo del reto: ", challenge_time, " segundos")


	# ==========================================
	# ANALISIS ADAPTATIVO
	# ==========================================

	var analysis = AdaptiveSystem.analyze_performance(
		ProgressManager.errors,
		ProgressManager.attempts,
		challenge_time
	)

	print("----- ANALISIS ADAPTATIVO -----")
	print("Intentos: ", analysis["attempts"])
	print("Errores: ", analysis["errors"])
	print("Tasa de error: ", analysis["error_rate"])
	print("Tiempo del reto: ", analysis["challenge_time"], " segundos")
	print("Rendimiento: ", analysis["performance"])
	print("Dificultad recomendada: ", analysis["recommended_difficulty"])


	# ==========================================
	# ANALISIS DEL HISTORIAL
	# ==========================================

	var history_analysis = AdaptiveSystem.analyze_history(
		ProgressManager.performance_history
	)

	print("----- ANALISIS DEL HISTORIAL -----")
	print("Total de retos: ", history_analysis["total_challenges"])
	print("Retos correctos: ", history_analysis["correct_challenges"])
	print("Retos incorrectos: ", history_analysis["incorrect_challenges"])
	print("Tasa de éxito: ", history_analysis["success_rate"])


	# ==========================================
	# ANALISIS POR CONCEPTO
	# ==========================================

	var concept_analysis = AdaptiveSystem.analyze_concepts(
		ProgressManager.performance_history
	)

	print("----- RENDIMIENTO POR CONCEPTO -----")

	for concept in concept_analysis:

		var data = concept_analysis[concept]

		print(
			"Concepto: ", concept,
			" | Retos: ", data["total"],
			" | Correctos: ", data["correct"],
			" | Incorrectos: ", data["incorrect"],
			" | Tasa de éxito: ", data["success_rate"]
		)


	# ==========================================
	# DETECTAR CONCEPTO MÁS DÉBIL
	# ==========================================

	var weakest_concept = AdaptiveSystem.get_weakest_concept(
		concept_analysis
	)

	print("----- CONCEPTO MAS DEBIL -----")
	print("Concepto detectado: ", weakest_concept)


	# ==========================================
	# GENERAR RECOMENDACIÓN DE LA IA
	# ==========================================

	var recommendation = AdaptiveSystem.generate_recommendation(
		analysis["performance"],
		analysis["recommended_difficulty"],
		weakest_concept
	)

	print("----- RECOMENDACION DE LA IA -----")
	print("Rendimiento detectado: ", recommendation["performance"])
	print("Concepto que necesita refuerzo: ", recommendation["weakest_concept"])
	print("Dificultad recomendada: ", recommendation["recommended_difficulty"])
	print("Accion: ", recommendation["action"])
	print("Mensaje: ", recommendation["message"])


	# ==========================================
	# SELECCIONAR SIGUIENTE RETO ADAPTATIVO
	# ==========================================

	var selected_challenge = challenge_manager.get_adaptive_challenge(
		recommendation["recommended_difficulty"],
		recommendation["weakest_concept"]
	)

	print("----- SIGUIENTE RETO ADAPTATIVO -----")
	print("Reto seleccionado: ", selected_challenge.challenge_name)
	print("Concepto: ", selected_challenge.concept)
	print("Dificultad: ", selected_challenge.difficulty)


	# ==========================================
	# RETO DEL CONCEPTO DÉBIL
	# ==========================================

	var concept_challenge = challenge_manager.get_challenge_by_concept(
		weakest_concept
	)

	print("----- RETO DEL CONCEPTO DEBIL -----")

	if concept_challenge != null:

		print("Reto seleccionado: ", concept_challenge.challenge_name)
		print("Concepto: ", concept_challenge.concept)
		print("Dificultad: ", concept_challenge.difficulty)

	else:

		print("No se encontró un reto para este concepto")


	# ==========================================
	# HISTORIAL DEL JUGADOR
	# ==========================================

	print("----- HISTORIAL DEL JUGADOR -----")

	for result in ProgressManager.performance_history:

		print(
			"Reto: ", result["challenge"],
			" | Concepto: ", result["concept"],
			" | Tiempo: ", result["time"],
			" | Correcto: ", result["correct"]
		)
