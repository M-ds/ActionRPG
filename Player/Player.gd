extends KinematicBody2D

const ACCELERATION = 10
const MAX_SPEED = 100
const FRICTION = 10

var velocity = Vector2.ZERO

# This function is called everytime the physics would update.
# Delta -> heeft de waarde die de waarde heeft van hoelang de vorige zelfde actie heeft.
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# this makes sure that in whatever direction the person is moving, the speed is constant in each direction
	# think about the graph, and the circle. The circle is the normalized part.
	input_vector = input_vector.normalized()
	
	if(input_vector != Vector2.ZERO):
		velocity += input_vector * ACCELERATION * delta
		# cap max speed
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	print(velocity)
	move_and_collide(velocity)
