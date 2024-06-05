extends CharacterBody2D

const SPEED = 130.0
const JUMP_VERLOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VERLOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
