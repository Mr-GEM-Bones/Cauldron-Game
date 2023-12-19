extends Node
var _test = "It works"
var _recipes = {
	"poison":["acid","slime","beard"],
	"slow":["pearl","bluecrystal","glitter"],
	"speed":["glitter","pearl","acid"],
	"strength":["pearl","beard","acid"],
	"weakness":["beard","slime","acid"],
	"health":["pearl","slime"],
	"harvest":["bluecrystal","slime"],
	"defense":["pearl","beard"],
	"mana":["glitter","bluecrystal"]
}

var _potions = {
	"health":"res://Scenes/Items/Potions/HealthPotion.tscn",
	"harvest":"res://Scenes/Items/Potions/HarvestPotion.tscn",
	"defense":"res://Scenes/Items/Potions/DefensePotion.tscn",
	"mana":"res://Scenes/Items/Potions/ManaPotion.tscn",
	"poison":"res://Scenes/Items/Potions/PoisonPotion.tscn",
	"slow":"res://Scenes/Items/Potions/SlowPotion.tscn",
	"speed":"res://Scenes/Items/Potions/SpeedPotion.tscn",
	"strength":"res://Scenes/Items/Potions/StrengthPotion.tscn",
	"weakness":"res://Scenes/Items/Potions/WeaknessPotion.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#Add the setup for the recipes here.
	


func get_recipe(index_value):
	return _recipes[index_value]
