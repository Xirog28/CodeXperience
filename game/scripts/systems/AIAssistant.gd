extends Node


# =========================================================
# ASISTENTE IA DE CODEXPERIENCE
# =========================================================

var assistant_name = "CodeX"


# =========================================================
# EXPLICACIONES
# =========================================================

var explanations = {
	"Variables": "Una variable es un espacio donde podemos guardar un dato para utilizarlo posteriormente. Por ejemplo: var score = 100.",
	"Condicionales": "Una condicion permite que el programa tome decisiones. Por ejemplo: if score >= 100: ejecuta el codigo cuando score sea mayor o igual a 100.",
	"Ciclos": "Un ciclo permite repetir una accion varias veces. Por ejemplo: for i in range(1, 6): permite recorrer los numeros del 1 al 5."
}


# =========================================================
# EXPLICAR CONCEPTO
# =========================================================

func explain_concept(concept):

	if explanations.has(concept):
		return explanations[concept]

	return "Todavia no tengo una explicacion especifica para este concepto."


# =========================================================
# GENERAR PISTA
# =========================================================

func generate_hint(challenge, performance):

	if challenge == null:
		return "Primero selecciona un reto para poder ayudarte."

	var concept = challenge.concept

	if concept == "Variables":

		if performance == "bajo":
			return "Pista: necesitas crear una variable llamada 'score' y asignarle un valor. Recuerda utilizar 'var'."

		if performance == "medio":
			return "Pista: piensa en un nombre para guardar el dato y despues asignale un valor."

		return "Pista: crea una variable utilizando la palabra 'var' y asignale el valor indicado."

	if concept == "Condicionales":

		if performance == "bajo":
			return "Pista: necesitas utilizar 'if' para comprobar si una condicion se cumple."

		if performance == "medio":
			return "Pista: utiliza una estructura que permita ejecutar codigo cuando una condicion sea verdadera."

		return "Pista: utiliza 'if' y comprueba la condicion indicada en el reto."

	if concept == "Ciclos":

		if performance == "bajo":
			return "Pista: necesitas repetir una accion utilizando un ciclo 'for'."

		if performance == "medio":
			return "Pista: piensa en un contador que pueda recorrer los numeros desde el inicio hasta el final."

		return "Pista: utiliza un ciclo 'for' para recorrer el rango indicado."

	return "Analiza el objetivo del reto y divide el problema en pasos pequenos."


# =========================================================
# RESPONDER PREGUNTAS
# =========================================================

func answer_question(question, concept, performance):

	var normalized_question = question.to_lower()

	if normalized_question.contains("que es"):
		return explain_concept(concept)

	if normalized_question.contains("explica"):
		return explain_concept(concept)

	if normalized_question.contains("no entiendo"):
		return explain_concept(concept)

	if normalized_question.contains("pista"):
		var challenge = _get_challenge_for_concept(concept)
		return generate_hint(challenge, performance)

	if normalized_question.contains("ayuda"):
		var challenge = _get_challenge_for_concept(concept)
		return generate_hint(challenge, performance)

	if normalized_question.contains("ayudar"):
		var challenge = _get_challenge_for_concept(concept)
		return generate_hint(challenge, performance)

	if normalized_question.contains("como"):
		var challenge = _get_challenge_for_concept(concept)
		return generate_hint(challenge, performance)

	return "Estoy aqui para ayudarte con el concepto " + concept + ". Puedes preguntarme que es, pedir una pista o decirme que parte del reto no entiendes."


# =========================================================
# BUSCAR RETO POR CONCEPTO
# =========================================================

func _get_challenge_for_concept(concept):

	var challenge_manager = preload("res://scripts/activities/ChallengeManager.gd").new()

	return challenge_manager.get_challenge_by_concept(concept)
