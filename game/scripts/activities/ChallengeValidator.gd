class_name ChallengeValidator
extends Object


func validate(challenge: ProgrammingChallenge, user_code: String) -> bool:
	var expected = challenge.expected_code.strip_edges()
	var submitted = user_code.strip_edges()

	return submitted == expected
