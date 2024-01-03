extends RigidBody2D

@export var mouse_drag_scale = 30

@export var ingredient = "A"

var _is_held = false
var _can_cauldron = true  #makes it able to interact with cauldron.

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Mouse clicked at: ", event.position)
			PickUpItem()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
		DropItem()

func PickUpItem():
	#this function changes everything that needs to change when an item is picked up.
	_is_held = true

func DropItem():
	#This function changes everything that needs to change when an item is released.
	_is_held = false

func _integrate_forces(state):
	#var linearvelocity = state.get_linear_velocity()
	state.apply_force(Vector2())
	if _is_held:
#		state.linear_velocity = get_global_mouse_position() - global_position
#		state.linear_velocity *= mouse_drag_scale 
		state.apply_central_impulse(mouse_drag_scale*(get_global_mouse_position()-global_position)-state.linear_velocity)
		#print("Velocity: ", linearvelocity)
