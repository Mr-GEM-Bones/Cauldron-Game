extends Node

var walking = true
var combat = false
@onready var timer = $EnemyTimer
@onready var enemy_anim = $EnemyPath/EnemyAnimation
@onready var potion_anim = $Wizard/PotionAnimation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#make background move while walking
	if walking == true:
		$ParallaxBackground.scroll_offset.x -= 200 * delta

func _input(_ev):
	#if Input.is_key_pressed(KEY_W):
	#	if walking == true:
	#		walking = false
	#	elif walking == false and anim.is_playing() == false:
	#		walking = true

	#throw poiton
	#if Input.is_key_pressed(KEY_T) and combat == true and potion_anim.is_playing() == false:
	#	$Wizard.throw_potion()
	pass

# Wizard throws the potion
func potion():
	$Wizard.throw_potion()

# Call to start combat
func start_combat():
	print("Combat started")
	enemy_anim.play("enemy_animation")
	timer.paused = true
	print("Timer paused")

# Calls when enemy is done with intro animation
func _on_enemy_animation_animation_finished(anim_name):
	if anim_name == "enemy_animation":
		combat = true
		walking = false
		print(anim_name)

# Call to end combat
func end_combat():
	print("Combat ended")
	timer.wait_time = 6
	combat = false
	enemy_anim.play("RESET")
	walking = true
	timer.paused = false
	print("Timer reset")

# Start combat when timer ends
func _on_enemy_timer_timeout():
	start_combat()

# End combat when wizard sends signal
func _on_wizard_sig_end_combat():
	end_combat()

#GEM 01/04/2024
