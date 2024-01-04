extends CharacterBody2D


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var cauldron_content = []
@onready var Recipes = $Recipes

var potion				#Holds the instantiated potion before adding it to the tree. Make sure to free it before instantiating a new one.
var current_potion_brew
var potion_delay_timer = 0
var potion_start_time = 1
var is_brewing = false
var potion_brewing_timer = 0		#Current Brew time.
var brew_time		#Set time for brew to be done. 

#DELETE
var spawn_ingredient_timer = 0
var spawn_ingredient_time = 1

func _ready():
	pass#Recipes = $Recipes

func _process(delta):
	##Timer to check the contents of the cauldron.
	#if potion_delay_timer>=potion_start_time:
		#CheckContents()
		#potion_delay_timer = 0 
	#else: 
		#potion_delay_timer += delta
		##$ProgressBar.value = potion_delay_timer
	
	#REMOVE! For testing, spawns randomingredients.
	if spawn_ingredient_timer >= spawn_ingredient_time:
		var size = Recipes._ingredients.size()
		var ing_key = Recipes._ingredients.keys()[randi() % size]
		SpawnIngredient(ing_key)
		spawn_ingredient_timer = 0
	else:
		spawn_ingredient_timer += delta
	
	#Timer for brewing potion.
	if is_brewing:
		if potion_brewing_timer>=brew_time:
			#Potion is done, create it.
			potion_brewing_timer=0
			StartPotion()
		else:
			potion_brewing_timer+=delta
			$ProgressBar.value = potion_brewing_timer

func SpawnIngredient(ing):
	#instantiate
	var ingredient = load(Recipes._ingredients[ing]).instantiate()
	
	#get random location in path.
	var spawnlocation = get_node("SpawnItem/SpawnLocation")
	spawnlocation.progress_ratio = randf()
	
	#set direction to be perpendicular.
	var direction = spawnlocation.rotation + PI / 2
	
	#Set ingredient position.
	ingredient.position = spawnlocation.position
	
	#add randomness to the direction
	direction += randf_range(-PI / 3, PI / 3)
	
	#velocity
	var velocity = Vector2(300.0,0.0)
	ingredient.linear_velocity = velocity.rotated(direction)
	add_child(ingredient)
	ingredient.just_produced()

func _on_area_2d_body_entered(body):
	#checks if the item can be used in the Cauldron. (newly produced potions should not.)
	if body._can_cauldron:
		#Add ingredient to the Cauldron.
		cauldron_content.append(body.ingredient)
		#make ingredient disapear.
		body.queue_free()
		#reset timer
		#potion_delay_timer = 0
		print(cauldron_content)
		CheckContents()

func CheckContents():
	#Start recipe Check
	for r_index in Recipes._recipes:
		var recipe_index = CheckRecipe(Recipes.get_recipe(r_index))
		#Check if a recepi has been found.
		if recipe_index.size() != 0:
			if is_brewing and r_index == current_potion_brew:
				pass
			else:
				#proceed to produce recipe.
				print("index: ", recipe_index, "potion: ", r_index)
				current_potion_brew = r_index
				SetupPotion(r_index)
				break

func SetupPotion(potion_index):
	#This function sets up all the function data for the potion.
	if potion:				#Makes sure that the variable is free before instantiating a potion.
		potion.queue_free()
	potion = load(Recipes._potions[potion_index]).instantiate()
	potion_brewing_timer=0
	brew_time = potion.brew_time
	$ProgressBar.max_value = brew_time
	$ProgressBar.visible = true
	is_brewing = true

func StartPotion():
	
	#randomly asign an angle to pop out the potion.
	var angle = randf_range(-PI / 5, PI / 5) - PI/2
	var aim = Vector2(cos(angle),sin(angle))
	potion.global_position = global_position
	#potion will poop out of the cauldron.
	potion.apply_impulse(aim * 900)
	get_parent().get_parent().add_child(potion)
	#make sure potion is tagged as just produced.
	potion.just_produced()
	potion = null		#Release the variable.
	#clears the contents of the cauldron.
	cauldron_content.clear()
	$ProgressBar.visible = false
	is_brewing = false

func CheckRecipe(_recipe):
	#This function returns array of index if _recipe is inside the cauldron and array of size 0 if not.
	#var is_recipe_in = true
	var recipe_index = [] #array to hold the index of all the recipe in the cauldron.
	
	#cycle through the entire recipe to check if the recepi is inside the cauldron.
	for i in _recipe:
		var ing = cauldron_content.find(i)
		if ing == -1:
			recipe_index.clear()
			break
		recipe_index.append(ing)
	
	return recipe_index
