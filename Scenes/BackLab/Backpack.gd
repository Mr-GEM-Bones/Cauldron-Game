extends CharacterBody2D


const SPEED = 1.0
const JUMP_VELOCITY = -900.0
var _is_bumped
var _move_velocity
var _force = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_T:
			bump(900)

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
	#print(global_position)
	# Handle jump.
	#if Input.is_action_just_pressed("ui_left"):
		#velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	if _is_bumped:
		velocity = _move_velocity * _force
		_is_bumped = false
		#rotation+=direction*SPEED*delta
	else:
		velocity = velocity.move_toward(Vector2(0,0),_force)
		
	move_and_slide()

func bump(force):
	var rng = RandomNumberGenerator.new()
	_move_velocity = Vector2(rng.randf_range(-1,1),rng.randf_range(-1,1)).normalized()
	_force = force
	_is_bumped = true
	
