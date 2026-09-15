extends Node


func _ready():

	# =========================================================
	# CREAR ASISTENTE
	# =========================================================

	var assistant = preload(
		"res://scripts/systems/AIAssistant.gd"
	).new()


	# =========================================================
	# DATOS DEL JUGADOR
	# =========================================================

	var concept = "Variables"
	var performance = "bajo"


	# =========================================================
	# PRUEBA 1 - EXPLICAR CONCEPTO
	# =========================================================

	print("")
	print("==========================================")
	print("          PRUEBA DEL ASISTENTE IA")
	print("==========================================")

	print("")
	print("Jugador:")
	print("Que es una variable?")

	var explanation = assistant.answer_question(
		"Que es una variable?",
		concept,
		performance
	)

	print("")
	print("CodeX:")
	print(explanation)


	# =========================================================
	# PRUEBA 2 - SOLICITAR AYUDA
	# =========================================================

	print("")
	print("------------------------------------------")

	print("Jugador:")
	print("Necesito ayuda con el reto")

	var hint = assistant.answer_question(
		"Necesito ayuda con el reto",
		concept,
		performance
	)

	print("")
	print("CodeX:")
	print(hint)


	# =========================================================
	# PRUEBA 3 - SOLICITAR PISTA
	# =========================================================

	print("")
	print("------------------------------------------")

	print("Jugador:")
	print("Dame una pista")

	var hint_2 = assistant.answer_question(
		"Dame una pista",
		concept,
		performance
	)

	print("")
	print("CodeX:")
	print(hint_2)


	# =========================================================
	# PRUEBA 4 - PREGUNTA GENERAL
	# =========================================================

	print("")
	print("------------------------------------------")

	print("Jugador:")
	print("Hola CodeX")

	var general_response = assistant.answer_question(
		"Hola CodeX",
		concept,
		performance
	)

	print("")
	print("CodeX:")
	print(general_response)


	# =========================================================
	# FINAL
	# =========================================================

	print("")
	print("==========================================")
	print("       FIN DE LA PRUEBA DEL ASISTENTE")
	print("==========================================")
