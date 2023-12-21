extends "res://Scenes/Items/Item.gd"

var _just_produced_timer = 4.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func just_produced():
	#this function makes sure that the potion does not interact with the cauldron.
	_can_cauldron = false
	collision_mask = 3
	await get_tree().create_timer(_just_produced_timer).timeout
	available()

func available():
	#this function sets everything to available when the potion can interact.
	#TODO optional, if the player catches the potion in the air, it can interact with cauldron, so run this.
	_can_cauldron = true
	collision_mask = 7
