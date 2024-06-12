extends CharacterBody2D

const SPEED = 130.0
const JUMP_VERLOCITY = -300.0
var is_die = false
var current_direction:float
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
	
	# Direction will be -1, 0, 1
	current_direction = Input.get_axis("move_left", "move_right")
	
	handle_player_movement()
	handle_player_flip()
	handle_animation()

func handle_player_movement() -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VERLOCITY
	
	if (current_direction and not is_die):
		animated_sprite.play("Run")
		velocity.x = current_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)

func handle_player_flip() -> void:
	if is_on_floor():
		if current_direction > 0:
			animated_sprite.flip_h = false
		if current_direction < 0:
			animated_sprite.flip_h = true

func handle_animation() -> void:
	if is_on_floor() and current_direction == 0 and not is_die:
		animated_sprite.play("Idle")
	if not is_on_floor() and not is_die:
		animated_sprite.play("Jump")

func die():
	is_die = true
	velocity.y = JUMP_VERLOCITY
	collision_shape.queue_free()
