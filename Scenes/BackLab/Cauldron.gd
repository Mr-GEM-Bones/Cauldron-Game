extends CharacterBody2D


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var cauldron_content = []
var recipe = ["pearl","slime"]


func _physics_process(delta):
	pass
#	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#	
#	move_and_slide()


func _on_area_2d_body_entered(body):
	cauldron_content.append(body.ingredient)
	body.queue_free()
	print(cauldron_content)


func CheckRecipe(_recipe):
	
	for i in _recipe:
		cauldron_content.find(i)
	return false
