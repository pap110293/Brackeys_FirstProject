extends CharacterBody2D

const SPEED = 130.0
const JUMP_VERLOCITY = -300.0
var is_die = false
@onready var collision_shape = $CollisionShape2D
@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta) -> void:
	player_controlling(delta)
	move_and_slide()

func player_controlling(delta) -> void:
	if not is_on_floor() and not is_die:
		velocity.y += gravity * delta
		
	if is_die:
		velocity.y += gravity * 2 * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VERLOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if (direction and not is_die):
		velocity.x = direction * SPEED
	else:
		velocity.x = 0.0

func die():
	is_die = true
	animated_sprite.play("Die")
