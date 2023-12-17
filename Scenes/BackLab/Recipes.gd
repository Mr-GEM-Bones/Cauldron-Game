extends Node
var _test = "It works"
var _recipes = {
	"health":["pearl","slime"]
}

var _potions = {
	"health":"res://Scenes/Items/HealthPotion.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#Add the setup for the recipes here.


func get_recipe(index_value):
	return _recipes[index_value]
