extends "res://Scenes/Items/Item.gd"


@export var brew_time = 5.0

signal potion_dropped(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func PickUpItem():
	super.PickUpItem()
	
	#change collision layer
	collision_layer = 2
	
func DropItem():
	super.DropItem()
	
	#Change collision layer back
	collision_layer = 1
	#emit signal to announce that the potion is dropped.
	emit_signal("potion_dropped",self)


