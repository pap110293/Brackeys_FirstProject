extends Node

@onready var score_label = $ScoreNumber

var score:int = 0

func add_score(score_to_add:int) -> void:
	score += score_to_add
	score_label.text = "You collected " + str(score) + " coins"
