class_name ProgrammingChallenge
extends Resource

@export var challenge_name: String = ""
@export var concept: String = ""
@export_range(1, 3) var difficulty: int = 1
@export_multiline var description: String = ""
@export_multiline var expected_code: String = ""
