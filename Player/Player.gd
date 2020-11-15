extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

var velocity = Vector2.ZERO

# Setting a reference to the animationPlayer function (underneath the player)
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
# Get access to the animation State, in order to toggle between idle and run
onready var animationState = animationTree.get("parameters/playback")

# This function is called everytime the physics would update.
# Delta -> heeft de waarde die de waarde heeft van hoelang de vorige zelfde actie heeft.
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if(input_vector != Vector2.ZERO):
		# Only update the blend position when the player is moving
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
