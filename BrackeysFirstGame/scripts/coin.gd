extends Area2D

@onready var game_manager = %GameManager
@onready var pickup_sound = $PickupSound
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	game_manager.add_score(1)
	animation_player.play("pick_up")
